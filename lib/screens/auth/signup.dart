// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spoonshare/controllers/auth/signup_controller.dart';
import 'package:spoonshare/l10n/app_localization.dart';
import 'package:spoonshare/screens/auth/signin.dart';
import 'package:spoonshare/screens/home/home.dart';
import 'package:spoonshare/utils/label_keys.dart';
import 'package:spoonshare/widgets/loader.dart';
import 'package:spoonshare/widgets/snackbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _signUpController = SignUpController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _contactNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  final SignUpController signUpController = SignUpController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var localization = AppLocalization.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: ScreenUtil().screenWidth,
            height: 860.h,
            padding: MediaQuery.of(context).padding,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().setHeight(120),
                      padding: const EdgeInsets.only(
                        top: 4,
                      ),
                      decoration: const BoxDecoration(color: Color(0xFFFF9F1C)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localization.translate(LabelKey.appName)!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.sp,
                              fontFamily: 'Lora',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.12,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            localization.translate(LabelKey.tagLine)!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: 280.w,
                  height: 75.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        localization.translate(LabelKey.slogan1)!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.sp,
                          fontFamily: 'Lora',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: 275.w,
                        child: Text(
                          localization.translate(LabelKey.slogan2)!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 14.sp,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: ScreenUtil().setWidth(218),
                  height: ScreenUtil().setHeight(38),
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1),
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(50)),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      signUpController.signUpWithGoogle(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(18),
                          height: ScreenUtil().setHeight(18),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/google.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        Text(
                          localization.translate(LabelKey.createAccountGoogle)!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(16)),
                SizedBox(
                  width: ScreenUtil().setWidth(296),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(8)),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: 12.sp,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputField(
                      label: localization.translate(LabelKey.fullName)!,
                      controller: _fullNameController,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(16)),
                    InputField(label: localization.translate(LabelKey.emailId)!, controller: _emailController),
                    SizedBox(height: ScreenUtil().setHeight(16)),
                    InputField(
                        label: localization.translate(LabelKey.contactNumber)!,
                        controller: _contactNumberController),
                    SizedBox(height: ScreenUtil().setHeight(16)),
                    InputField(
                      label: localization.translate(LabelKey.password)!,
                      isPassword: true,
                      controller: _passwordController,
                      isPasswordVisible: _isPasswordVisible,
                      togglePasswordVisibility: () {
                        _togglePasswordVisibility();
                      },
                    ),
                    SizedBox(height: ScreenUtil().setHeight(16)),
                    InputField(
                      label: localization.translate(LabelKey.confirmPassword)!,
                      isPassword: true,
                      controller: _confirmPasswordController,
                      isPasswordVisible: _isConfirmPasswordVisible,
                      togglePasswordVisibility: () {
                        _toggleConfirmPasswordVisibility();
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: SizedBox(
                    width: ScreenUtil().setWidth(296),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                            localization.translate(LabelKey.termsAndCondition1)!,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 11.sp,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: localization.translate(LabelKey.privacyPolicy),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.sp,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: ' & ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 11.sp,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: localization.translate(LabelKey.terms),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.sp,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: localization.translate(LabelKey.alreadyAccount),
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 16.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: localization.translate(LabelKey.login),
                            style: TextStyle(
                              color: const Color(0xFFFF9F1C),
                              fontSize: 16.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                ElevatedButton(
                  onPressed: () async {
                    showLoadingDialog(context);

                    try {
                      await _signUpController.signUp(
                        fullName: _fullNameController.text,
                        email: _emailController.text,
                        contactNumber: _contactNumberController.text,
                        password: _passwordController.text,
                        confirmPassword: _confirmPasswordController.text,
                        context: context,
                      );

                      Navigator.of(context).pop();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        ModalRoute.withName('/'),
                      );
                    } catch (e) {
                      print("Signup failed: $e");

                      Navigator.of(context).pop();

                      showErrorSnackbar(
                          context, 'Signup failed. Please try again.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9F1C),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(50)),
                    ),
                  ),
                  child: SizedBox(
                    width: 250.h,
                    height: 45.h,
                    child: Center(
                      child: Text(
                        localization.translate(LabelKey.createAccount)!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.36,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }
}

class InputField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final bool? isPasswordVisible;
  final VoidCallback? togglePasswordVisibility;

  const InputField({
    Key? key,
    required this.label,
    this.isPassword = false,
    required this.controller,
    this.isPasswordVisible,
    this.togglePasswordVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: const Color(0x4CFF9F1C),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword && isPasswordVisible != true,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.black.withOpacity(0.38),
                  fontSize: 14,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  leadingDistribution: TextLeadingDistribution.even,
                  letterSpacing: 1.2,
                ),
                border: InputBorder.none,
                suffixIcon: isPassword && togglePasswordVisibility != null
                    ? IconButton(
                        icon: Icon(
                          isPasswordVisible!
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: togglePasswordVisibility,
                      )
                    : null,
              ),
            ),
          ),
          const Text(
            '*', // Asterisk symbol
            style: TextStyle(
              color: Color(0x99F20F0F),
              fontSize: 14,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
