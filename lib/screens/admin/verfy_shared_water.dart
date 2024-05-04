// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:spoonshare/widgets/snackbar.dart';

class VerifySharedWater extends StatefulWidget {
  const VerifySharedWater({Key? key}) : super(key: key);

  @override
  _VerifySharedWaterState createState() => _VerifySharedWaterState();
}

class _VerifySharedWaterState extends State<VerifySharedWater> {
  late Stream<QuerySnapshot> _waterStream;

  @override
  void initState() {
    super.initState();
    _waterStream = const Stream.empty();
    _initializeWaterStream();
  }

  void _initializeWaterStream() {
    _waterStream = FirebaseFirestore.instance
        .collection('water')
        .doc('sharedWater')
        .collection('waterData')
        .where('verified', isEqualTo: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Shared Free Water'),
        backgroundColor: const Color(0xFFFF9F1C),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'DM Sans',
            fontSize: 18,
            fontWeight: FontWeight.w700),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Position>(
        future: Geolocator.getCurrentPosition(),
        builder: (context, positionSnapshot) {
          if (positionSnapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          } else if (positionSnapshot.hasError) {
            return Text('Error: ${positionSnapshot.error}');
          }

          Position userLocation = positionSnapshot.data!;

          return StreamBuilder<QuerySnapshot>(
            stream: _waterStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              var waterDocs = snapshot.data!.docs;
     
              // Sort the water documents based on distance
              waterDocs.sort((a, b) {
                GeoPoint waterALocation = a['location'];
                GeoPoint waterBLocation = b['location'];

                double distanceA = Geolocator.distanceBetween(
                  userLocation.latitude,
                  userLocation.longitude,
                  waterALocation.latitude,
                  waterALocation.longitude,
                );

                double distanceB = Geolocator.distanceBetween(
                  userLocation.latitude,
                  userLocation.longitude,
                  waterBLocation.latitude,
                  waterBLocation.longitude,
                );

                return distanceA.compareTo(distanceB);
              });

              return ListView.builder(
                itemCount: waterDocs.length,
                itemBuilder: (context, index) {
                  Object? waterData = waterDocs[index].data();
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WaterDetailsPage(waterDoc: waterDocs[index]),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      color: const Color(0xFFFF9F1C),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              (waterData as Map?)?['imageUrl'] ?? ''),
                          radius: 30,
                        ),
                        title: Text(
                          (waterData)?['venue'] ?? 'No Venue',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'DM Sans',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          waterData?['address'] ?? 'No Address',
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'DM Sans',
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      
    );
  }
}

class WaterDetailsPage extends StatelessWidget {
  final QueryDocumentSnapshot waterDoc;

  const WaterDetailsPage({Key? key, required this.waterDoc}) : super(key: key);

  String _formatDate(String date) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('dd-MM-yyyy');
    final formattedDate = outputFormat.format(inputFormat.parse(date));
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    Object? waterData = waterDoc.data();
    return Scaffold(
      appBar: AppBar(
        title: Text((waterData as Map?)?['venue'] ?? 'No Venue'),
        backgroundColor: const Color(0xFFFF9F1C),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'DM Sans',
            fontSize: 18,
            fontWeight: FontWeight.w700),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    )),
                    child: Image.network(
                      waterData!['imageUrl'] ?? '',
                      height: 250,
                      width: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      'Venue: ${waterData['venue'] ?? ''}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      'Uploaded By: ${waterData['fullName'] ?? ''}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      'Location: ${waterData['address'] ?? ''}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                 const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () => _verifyWater(waterDoc, context),
                        child: const Text('Verify'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () => _deleteWater(waterDoc, context),
                        child: const Text('Don\'t Verify'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}

// Function to handle verification logic
Future<void> _verifyWater(DocumentSnapshot waterDoc, BuildContext context) async {
  try {
    await FirebaseFirestore.instance
        .collection('water')
        .doc('sharedwater')
        .collection('waterData')
        .doc(waterDoc.id)
        .update({'verified': true});
    showSuccessSnackbar(context, 'Water verified successfully');
    Navigator.pop(context);
  } catch (e) {
    showErrorSnackbar(context, 'Error verifying water');
  }
}

// Function to handle deletion logic
Future<void> _deleteWater(DocumentSnapshot waterDoc, BuildContext context) async {
  try {
    await FirebaseFirestore.instance
        .collection('water')
        .doc('sharedwater')
        .collection('waterData')
        .doc(waterDoc.id)
        .delete();
    showSuccessSnackbar(context, 'Water deleted successfully');
    Navigator.pop(context);
  } catch (e) {
    showErrorSnackbar(context, 'Error deleting water');
  }
}
