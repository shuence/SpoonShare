// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spoonshare/l10n/app_localization.dart';
import 'package:spoonshare/models/users/user.dart';
import 'package:spoonshare/utils/label_keys.dart';
import 'package:spoonshare/widgets/custom_text_field.dart';
import 'package:spoonshare/widgets/snackbar.dart';

class NGO {
  final String ngoname;
  final String description;

  NGO(this.ngoname, this.description);

  @override
  String toString() {
    return ngoname;
  }
}

class VolunteerFormScreen extends StatefulWidget {
  const VolunteerFormScreen({Key? key}) : super(key: key);

  @override
  _VolunteerFormScreenState createState() => _VolunteerFormScreenState();
}

class _VolunteerFormScreenState extends State<VolunteerFormScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final GlobalKey<FormFieldState<NGO?>> _ngoKey = GlobalKey();

  List<NGO> _ngos = [];

  @override
  void initState() {
    super.initState();
    fetchNGOData();
    fetchUserProfileData();
  }

  Future<void> fetchNGOData() async {
    try {
      // Fetch NGO data from Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('ngos').get();

      // Convert query snapshot to a list of NGO objects
      List<NGO> ngos = querySnapshot.docs.map((doc) {
        return NGO(doc['ngoName'], doc['description']);
      }).toList();

      setState(() {
        _ngos = ngos;
      });
    } catch (error) {
      // Handle errors if any
    }
  }

  Future<void> fetchUserProfileData() async {
    // Initialize UserProfile instance
    UserProfile userProfile = UserProfile();

    // Load user profile data
    await userProfile.loadUserProfile();

    // Set text controllers with fetched data
    setState(() {
      _fullNameController.text = userProfile.getFullName();
      _mobileNoController.text = userProfile.getContactNumber();
      _emailController.text = userProfile.getEmail();
    });
  }

  String? _selectedGender;
  DateTime? _selectedBirthday;
  NGO? _selectedNGO;

  bool _validateFields() {
    return _fullNameController.text.isNotEmpty &&
        _mobileNoController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _selectedGender != null &&
        _selectedBirthday != null &&
        (_occupationController.text.isNotEmpty ||
            _addressController.text.isNotEmpty) &&
        _selectedNGO != null;
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate(LabelKey.volunteerForm)!),
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
            CustomTextField(
              label: localization.translate(LabelKey.fullName)!,
              controller: _fullNameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization.translate(LabelKey.mobileNo)!,
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
                value: _selectedGender,
                hint: Text(
                  localization.translate(LabelKey.selectGender)!,
                ),
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
                    _selectedGender = newValue;
                  });
                },
                items: [
                  localization.translate(LabelKey.genderMale)!,
                  localization.translate(LabelKey.genderfemale)!,
                  localization.translate(LabelKey.genderNotSay)!,
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
                    labelText: localization.translate(LabelKey.birthday)!,
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
                controller: _selectedBirthday == null
                    ? null
                    : TextEditingController(
                        text:
                            '${_selectedBirthday!.day}/${_selectedBirthday!.month}/${_selectedBirthday!.year}',
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
                      _selectedBirthday = selectedDate;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization.translate(LabelKey.occupation)!,
              controller: _occupationController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization.translate(LabelKey.address)!,
              controller: _addressController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: localization.translate(LabelKey.linkedInInstagramLinks)!,
              controller: _linkedinController,
            ),
            const SizedBox(height: 16),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
              child: Autocomplete<NGO>(
                key: _ngoKey,
                optionsBuilder: (TextEditingValue textEditingValue) {
                  final options = _ngos.where((ngo) => ngo.ngoname
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                  return options.toList();
                },
                onSelected: (NGO? value) {
                  setState(() {
                    _selectedNGO = value;
                  });
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextFormField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    decoration: InputDecoration(
                      labelText: localization.translate(LabelKey.selectNgo)!,
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
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black87,
                        fontFamily: 'DM Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<NGO> onSelected,
                    Iterable<NGO> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: SizedBox(
                        height: 250.0,
                        child: ListView.builder(
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final NGO option = options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                              },
                              child: ListTile(
                                title: Text(option.ngoname),
                                subtitle: Text(option.description),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
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
    var localization = AppLocalization.of(context)!;

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
      ),
    );
  }

  Future<void> _submitForm() async {
    var localization = AppLocalization.of(context)!;

    if (_validateFields()) {
      try {
        // Add volunteer data to Firebase
        await FirebaseFirestore.instance.collection('volunteers').add({
          'fullName': _fullNameController.text,
          'mobileNo': _mobileNoController.text,
          'email': _emailController.text,
          'gender': _selectedGender,
          'birthday': _selectedBirthday,
          'occupation': _occupationController.text,
          'address': _addressController.text,
          'linkedin': _linkedinController.text,
          'ngo': _selectedNGO!.ngoname,
          'verified': false,
        });

        _fullNameController.clear();
        _mobileNoController.clear();
        _emailController.clear();
        _occupationController.clear();
        _addressController.clear();
        _linkedinController.clear();
        _selectedGender = null;
        _selectedBirthday = null;
        _selectedNGO = null;

        // Show success message
        showSuccessSnackbar(
          context,
          localization.translate(LabelKey.formSubmittedSuccessfully)!,
        );
        Navigator.pop(context);
      } catch (error) {
        // Show error message if submission fails
        showErrorSnackbar(context,
            '${localization.translate(LabelKey.errorSubmitting)!}$error');
      }
    } else {
      // Show error message indicating that all fields are required
      showErrorSnackbar(
          context, localization.translate(LabelKey.allFieldsRequired)!);
    }
  }
}
