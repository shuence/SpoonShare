// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spoonshare/l10n/app_localization.dart';
import 'package:spoonshare/models/users/user.dart';
import 'package:spoonshare/screens/donate/thank_you.dart';
import 'package:spoonshare/utils/label_keys.dart';
import 'package:spoonshare/widgets/auto_complete.dart';
import 'package:spoonshare/widgets/custom_text_field.dart';
import 'package:spoonshare/widgets/loader.dart';
import 'package:spoonshare/widgets/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class ShareWaterScreenContent extends StatefulWidget {
  const ShareWaterScreenContent({super.key});

  @override
  _ShareWaterScreenContentState createState() =>
      _ShareWaterScreenContentState();
}

class _ShareWaterScreenContentState extends State<ShareWaterScreenContent> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  File? _imageFile;
  late double lat;
  late double lng;
  bool _addressSelected = false;

  String tokenForSession = "12345";
  List<Map<String, dynamic>> listForPlaces = [];
  var uuid = const Uuid();

  Future<void> makeSuggestions(String input) async {
    try {
      var suggestions = await PlaceApi.getSuggestions(input);
      setState(() {
        listForPlaces = suggestions;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _addressController.addListener(onModify);
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void onModify() {
    if (tokenForSession.isEmpty) {
      setState(() {
        tokenForSession = uuid.v4();
      });
    }
    makeSuggestions(_addressController.text);
  }

  Future<void> handleListItemTap(int index) async {
    String placeId = listForPlaces[index]['place_id'];
    var placeDetails = await PlaceApi.getPlaceDetails(placeId);
    double selectedLat = placeDetails['geometry']['location']['lat'];
    double selectedLng = placeDetails['geometry']['location']['lng'];
    String selectedAddress = listForPlaces[index]['description'];

    setState(() {
      _addressController.text = selectedAddress;
      lat = selectedLat;
      lng = selectedLng;
      _addressSelected = true; // Set _addressSelected to true
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showExpandedList =
        _addressController.text.isNotEmpty && !_addressSelected;
    var localization = AppLocalization.of(context);

    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildImageUploadBox(),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization!.translate(LabelKey.venueShareFoodForm)!,
              controller: _venueController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization.translate(LabelKey.enterAddress)!,
              controller: _addressController,
            ),
            if (showExpandedList)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: listForPlaces.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        _addressSelected = true;
                        await handleListItemTap(index);
                      },
                      title: Text(
                        listForPlaces[index]['description'],
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadBox() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              pickFile();
            },
            child: Container(
              width: 280,
              height: 180,
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.07999999821186066),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.black.withOpacity(0.6000000238418579),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _imageFile == null
                  ? const Icon(
                      Icons.camera_alt,
                      size: 48,
                      color: Colors.grey,
                    )
                  : Image.file(
                      _imageFile!,
                      width: 48, // Adjust the size as needed
                      height: 48, // Adjust the size as needed
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '* Fill below details to share water',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pickFile() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    late final Map<Permission, PermissionStatus> status;
    if (androidInfo.version.sdkInt <= 32) {
      status = await [
        Permission.storage,
        Permission
            .camera, // Request camera permission for devices with SDK <= 32
      ].request();
    } else {
      status = await [
        Permission.photos,
        Permission.camera,
        Permission.notification,
      ].request();
    }

    var allAccepted = true;
    status.forEach((permission, status) {
      if (status != PermissionStatus.granted) {
        allAccepted = false;
      }
    });

    if (allAccepted) {
      // Show options for gallery or camera
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          var localization = AppLocalization.of(context)!;

          return Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text(localization.translate(LabelKey.pickGallery)!),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: Text(localization.translate(LabelKey.captureCamera)!),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.camera);
                },
              ),
            ],
          );
        },
      );
    } else {}
  }

  Future<void> _pickImage(ImageSource source) async {
    XFile? pickedImage = await ImagePicker().pickImage(
      source: source,
    );

    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
      _imageController.text = _imageFile!.path;
      setState(() {});
    }
  }

   Widget _buildSubmitButton() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var localization = AppLocalization.of(context)!;

    return Container(
      width: screenWidth * 0.8667,
      height: screenHeight * 0.05625,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9F1C),
        borderRadius: BorderRadius.circular(50),
      ),
      child: InkWell(
        onTap: () {
          submitFood();
        },
        child: Center(
          child: Text(
            localization.translate(LabelKey.submitButton)!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.36,
            ),
          ),
        ),
      ),
    );
  }

  void submitFood() async {
    if (_imageFile == null ||
        _venueController.text.isEmpty ||
        _addressController.text.isEmpty) {
      showErrorSnackbar(context, 'Please fill all required fields');
      return;
    }

    try {
      showLoadingDialog(context);

      String userId = FirebaseAuth.instance.currentUser!.uid;
      UserProfile userProfile = UserProfile();
      String fullName = userProfile.getFullName();
      String venue = _venueController.text;
      String address = _addressController.text;

      // Upload the image to Firebase Storage
      String imageUrl = await uploadImageToFirebaseStorage(_imageFile, venue);

      // Create a GeoPoint with the latitude and longitude
      GeoPoint location = GeoPoint(lat, lng);

      // Create a map with food details, including a timestamp
      Map<String, dynamic> foodData = {
        'userId': userId,
        'fullName': fullName,
        'imageUrl': imageUrl,
        'venue': venue,
        'address': address,
        'location': location,
        'verified': false,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('water')
          .doc('sharedWater')
          .collection("waterData")
          .add(foodData);

      // Show success message
      showSuccessSnackbar(context, 'Food submitted successfully!');
      // Navigate to thank you screen
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ThankYouScreen()));
    } catch (e) {
      showErrorSnackbar(context, 'Error submitting food');
    } finally {
      // Clear text controllers and reset selected food type
      _venueController.clear();
      _addressController.clear();
      _imageController.clear();
      _imageFile = null;
    }
  }

  Future<String> uploadImageToFirebaseStorage(
      File? imageFile, String venue) async {
    if (imageFile == null) {
      throw Exception('Image file is null');
    }

    try {
      String fileName = 'water/shared_water/$venue.jpg';

      firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      await storageReference.putFile(imageFile);

      String downloadURL = await storageReference.getDownloadURL();

      return downloadURL;
    } catch (e) {
      throw Exception('Error uploading image to Firebase Storage');
    }
  }
}

class ShareWaterScreen extends StatelessWidget {
  const ShareWaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate(LabelKey.shareWaterForm)!),
        backgroundColor: const Color(0xFFFF9F1C),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Lora',
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
      body: Container(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              ShareWaterScreenContent(),
            ],
          ),
        ),
      ),
    );
  }
}
