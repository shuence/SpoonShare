import 'dart:async';
import 'dart:ui' as Codec;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';
import 'package:spoonshare/l10n/app_localization.dart';
import 'package:spoonshare/screens/fooddetails/food_details.dart';
import 'package:spoonshare/screens/fooddetails/water_details.dart';
import 'package:spoonshare/utils/label_keys.dart';

class MapsWidget extends StatefulWidget {
  const MapsWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  late GoogleMapController mapController;
  location.LocationData? currentLocation;
  late BitmapDescriptor customMarkerIcon;
  late BitmapDescriptor customNgoMarkerIcon;
  late BitmapDescriptor customwaterMarkerIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      _getCurrentLocation();
    } else if (status == PermissionStatus.denied) {
    } else if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _getCurrentLocation() async {
    location.LocationData locationData =
        await location.Location().getLocation();
    setState(() {
      currentLocation = locationData;
    });
  }

  void _navigateToFoodDetails(BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsScreen(data: data),
      ),
    );
  }


  void _navigateTowaterDetails(BuildContext context, QueryDocumentSnapshot data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WaterDetailsScreen(waterDoc: data),
      ),
    );
  }

  Future<void> _loadCustomMarker() async {
    Uint8List markerIcon =
        await getBytesFromAsset('assets/images/marker_icon.png', 100);
    customMarkerIcon = BitmapDescriptor.fromBytes(markerIcon);

    Uint8List ngoMarkerIcon =
        await getBytesFromAsset('assets/images/ngo_marker.png', 100);
    customNgoMarkerIcon = BitmapDescriptor.fromBytes(ngoMarkerIcon);

    Uint8List waterMarkerIcon =
        await getBytesFromAsset('assets/images/water.png', 100);
    customwaterMarkerIcon = BitmapDescriptor.fromBytes(waterMarkerIcon);
  }

  Future<List<Marker>> _initializeMap() async {
    List<Marker> markers = [];

    // Add markers for shared food
    QuerySnapshot sharedFoodSnapshot = await FirebaseFirestore.instance
        .collection('food')
        .doc('sharedfood')
        .collection('foodData')
        .get();

    for (var doc in sharedFoodSnapshot.docs) {
      double lat = doc['location'].latitude;
      double lng = doc['location'].longitude;
      String venue = doc['venue'];
      bool dailyActive = doc['dailyActive'] ?? true;
      bool isVerified = doc['verified'] ?? true;

      if (!dailyActive) {
        bool isFoodPast = isPast(doc.data() as Map<String, dynamic>);
        if (isVerified && !isFoodPast) {
          InfoWindow infoWindow = InfoWindow(
            title: venue,
            snippet: "click here for more details",
            onTap: () => _navigateToFoodDetails(
                context, doc.data() as Map<String, dynamic>),
          );

          Marker marker = Marker(
            markerId: MarkerId('$lat,$lng'),
            position: LatLng(lat, lng),
            infoWindow: infoWindow,
            icon: customMarkerIcon,
          );

          markers.add(marker);
        }
      } else {
        if (isVerified) {
          InfoWindow infoWindow = InfoWindow(
            title: venue,
            snippet: "click here for more details",
            onTap: () => _navigateToFoodDetails(
                context, doc.data() as Map<String, dynamic>),
          );

          Marker marker = Marker(
            markerId: MarkerId('$lat,$lng'),
            position: LatLng(lat, lng),
            infoWindow: infoWindow,
            icon: customMarkerIcon,
          );
          markers.add(marker);
        }
      }
    }

    // Add markers for NGOs
    QuerySnapshot ngoSnapshot = await FirebaseFirestore.instance
        .collection('ngos')
        .where('verified', isEqualTo: true)
        .get();

    for (var doc in ngoSnapshot.docs) {
      double lat = doc['location'].latitude;
      double lng = doc['location'].longitude;
      String name = doc['ngoName'];

      InfoWindow infoWindow = InfoWindow(
        title: name,
        snippet: "NGO location",
      );

      Marker marker = Marker(
        markerId: MarkerId('$lat,$lng'),
        position: LatLng(lat, lng),
        infoWindow: infoWindow,
        icon: customNgoMarkerIcon,
      );

      markers.add(marker);
    }
    

  // Add markers for water
    QuerySnapshot waterSnapshot = await FirebaseFirestore.instance
        .collection('water')
        .doc('sharedWater')
        .collection('waterData')
        .where('verified', isEqualTo: true)
        .get();

    for (var doc in waterSnapshot.docs) {
      double lat = doc['location'].latitude;
      double lng = doc['location'].longitude;
      String name = doc['venue'];

      InfoWindow infoWindow = InfoWindow(
        title: name,
        snippet: "Water location",
        onTap: () {
          _navigateTowaterDetails(context, doc);
        },
      );

      Marker marker = Marker(
        markerId: MarkerId('$lat,$lng'),
        position: LatLng(lat, lng),
        infoWindow: infoWindow,
        icon: customwaterMarkerIcon,
      );

      markers.add(marker);
    }
    return markers;
  }

  bool isPast(Map<String, dynamic> data) {
    String toDateString = data['toDate']?.trim() ?? '';
    String toTimeString = data['toTime']?.trim() ?? '';

    // Parse to date and time
    DateTime toDate = DateFormat('yyyy-MM-dd').parse(toDateString);
    DateTime toTime = DateFormat('hh:mm a').parse(toTimeString);

    // Combine date and time into a single DateTime object
    DateTime combinedDateTime = DateTime(
      toDate.year,
      toDate.month,
      toDate.day,
      toTime.hour,
      toTime.minute,
    );

    // Format the current date and time
    DateTime currentDateTime = DateTime.now();

    return combinedDateTime.isBefore(currentDateTime);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec.Codec codec = await Codec.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width);
    Codec.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: Codec.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
        var localization = AppLocalization.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate(LabelKey.mapAppBarTitle)!),
        backgroundColor: const Color(0xFFFF9F1C),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Lora',
            fontSize: 18,
            fontWeight: Codec.FontWeight.w700),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: currentLocation != null
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 16,
                    height: MediaQuery.of(context).size.height - 170,
                    child: FutureBuilder<List<Marker>>(
                      future: _initializeMap(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return GoogleMap(
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                            },
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                currentLocation!.latitude!,
                                currentLocation!.longitude!,
                              ),
                              zoom: 12.0,
                            ),
                            markers: Set<Marker>.of(snapshot.data ?? []),
                            myLocationEnabled: true,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
