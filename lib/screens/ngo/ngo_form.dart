// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoonshare/l10n/app_localization.dart';
import 'package:spoonshare/models/users/user.dart';
import 'package:spoonshare/screens/home/home.dart';
import 'package:spoonshare/utils/label_keys.dart';
import 'package:spoonshare/widgets/custom_text_field.dart';
import 'package:spoonshare/widgets/auto_complete.dart';
import 'package:spoonshare/widgets/snackbar.dart';
import 'package:uuid/uuid.dart';

class NGOFormScreen extends StatefulWidget {
  const NGOFormScreen({Key? key}) : super(key: key);

  @override
  NGOFormScreenState createState() => NGOFormScreenState();
}

class NGOFormScreenState extends State<NGOFormScreen> {
  final TextEditingController _ngoNameController = TextEditingController();
  final TextEditingController _ngoNoController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _decripationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserProfileData();
    _addressController.addListener(onModify);
  }

  Future<void> fetchUserProfileData() async {
    // Initialize UserProfile instance
    UserProfile userProfile = UserProfile();

    // Load user profile data
    await userProfile.loadUserProfile();

    // Set text controllers with fetched data
    setState(() {
      _mobileNoController.text = userProfile.getContactNumber();
      _emailController.text = userProfile.getEmail();
    });
  }

  String? _selectedType;
  DateTime? _selectedIncorporationDay;
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
      lat =
          selectedLat; // Update the class-level variables with the selected values
      lng = selectedLng;
      _addressSelected = true; // Set _addressSelected to true
    });
  }

  bool _validateFields() {
    return _ngoNameController.text.isNotEmpty &&
        _ngoNoController.text.isNotEmpty &&
        _mobileNoController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _selectedType != null &&
        _selectedIncorporationDay != null &&
        (_decripationController.text.isNotEmpty ||
            _addressController.text.isNotEmpty) &&
        _linkedinController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    bool showExpandedList =
        _addressController.text.isNotEmpty && !_addressSelected;
        var localization = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text(localization!.translate(LabelKey.ngoForm)!),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildImageUploadBox(),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization.translate(LabelKey.ngoName)!,
              controller: _ngoNameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization.translate(LabelKey.ngoNo)!,
              controller: _ngoNoController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization.translate(LabelKey.ngoMobileNo)!,
              controller: _mobileNoController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization.translate(LabelKey.emailAddress)!,
              controller: _emailController,
            ),
            const SizedBox(height: 16),
            Container(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
              child: DropdownButtonFormField<String>(
                value: _selectedType,
                hint:  Text(localization.translate(LabelKey.ngoType)!),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF9F1C),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF9F1C),
                      ),
                    )),
                onChanged: (newValue) {
                  setState(() {
                    _selectedType = newValue;
                  });
                },
                items: [  localization.translate(LabelKey.ngoFoodDonation)!,
                  localization.translate(LabelKey.ngoCharity)!,
                  localization.translate(LabelKey.ngoNotSay)!,
              ]
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: localization.translate(LabelKey.incorporationDate)!,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF9F1C),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF9F1C),
                      ),
                    )),
                readOnly: true,
                controller: _selectedIncorporationDay == null
                    ? null
                    : TextEditingController(
                        text:
                            '${_selectedIncorporationDay!.day}/${_selectedIncorporationDay!.month}/${_selectedIncorporationDay!.year}',
                      ),
                onTap: () async {
                  final DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _selectedIncorporationDay = selectedDate;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization.translate(LabelKey.description)!,
              controller: _decripationController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization.translate(LabelKey.address)!,
              controller: _addressController,
            ),
            if (showExpandedList)
              Container(
                height: 200, // Set the height of the suggestions container
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
            CustomTextField(
              label: localization.translate(LabelKey.linkedInInstagramLinks)!,
              controller: _linkedinController,
            ),
            _buildSubmitButton()
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var localization = AppLocalization.of(context);
    return Center(
      child: Container(
        width: screenWidth * 0.8667,
        height: screenHeight * 0.05625,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFF9F1C),
          borderRadius: BorderRadius.circular(50),
        ),
        child: InkWell(
          onTap: () {
            _submitForm();
          },
          child:  Center(
            child: Text(
              localization!.translate(LabelKey.submitButton)!,
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
      ),
    );
  }

  Widget _buildImageUploadBox() {
    var localization = AppLocalization.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              pickFile();
            },
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                shape: BoxShape.circle, // Circular shape
                border: Border.all(
                  width: 2,
                  color: Colors.black.withOpacity(0.6),
                ),
                image: _imageFile != null
                    ? DecorationImage(
                        image: FileImage(_imageFile!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _imageFile == null
                  ? const Icon(
                      Icons.camera_alt,
                      size: 48,
                      color: Colors.grey,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 8),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              localization!.translate(LabelKey.uploadLogo)!,
              style: const TextStyle(
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
        Permission.camera,
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
    } else {
      const Center(
        child: Text("Storage or camera permission denied"),
      );
    }
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

  Future<String> uploadImageToFirebaseStorage(
      File? imageFile, String venue) async {
    if (imageFile == null) {
      throw Exception('Image file is null');
    }

    try {
      String fileName = 'ngo/$venue.jpg';

      firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      await storageReference.putFile(imageFile);

      String downloadURL = await storageReference.getDownloadURL();

      return downloadURL;
    } catch (e) {
      showErrorSnackbar(
        context,
        'Error uploading image to Firebase Storage',
      );
      throw Exception('Error uploading image to Firebase Storage');
    }
  }

  Future<void> _submitForm() async {
    if (_validateFields()) {
      try {
        // Show loader
        showDialog(
          context: context,
          barrierDismissible: false, // Prevent dialog from being dismissed
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Submitting Form...'),
                ],
              ),
            );
          },
        );

        // Upload image to Firebase Storage
        String imageUrl = await uploadImageToFirebaseStorage(
          _imageFile,
          _ngoNameController.text,
        );

        GeoPoint location = GeoPoint(lat, lng);

        await FirebaseFirestore.instance.collection('ngos').add({
          'ngoName': _ngoNameController.text,
          'ngoNo': _ngoNoController.text,
          'mobileNo': _mobileNoController.text,
          'email': _emailController.text,
          'ngoImage': imageUrl,
          'type': _selectedType,
          'incorporationDay': _selectedIncorporationDay,
          'description': _decripationController.text,
          'address': _addressController.text,
          'location': location,
          'linkedin': _linkedinController.text,
          'verified': false,
        });

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('organisation', _ngoNameController.text);
        prefs.setString('role', 'NGO');

        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        String userId = FirebaseAuth.instance.currentUser!.uid;

        await users.doc(userId).update({
          'organisation': _ngoNameController.text,
          'role': 'NGO',
        });

        _ngoNameController.clear();
        _mobileNoController.clear();
        _emailController.clear();
        _decripationController.clear();
        _addressController.clear();
        _linkedinController.clear();
        _selectedType = null;
        _selectedIncorporationDay = null;

        // Close the dialog
        Navigator.pop(context);

        showSuccessSnackbar(
          context,
          'Form submitted successfully. We will get back to you soon.',
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } catch (error) {
        // Close the dialog
        Navigator.pop(context);

        showErrorSnackbar(
          context,
          'Error submitting form. Please try again later.',
        );
      }
    } else {
      showErrorSnackbar(
        context,
        'Please fill all the required fields',
      );
    }
  }
}
