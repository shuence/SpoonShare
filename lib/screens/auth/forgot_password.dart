import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spoonshare/screens/auth/signup.dart';
import 'package:spoonshare/services/forgot_password.dart';
import 'package:spoonshare/widgets/custom_button.dart';
import 'package:spoonshare/widgets/snackbar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final ForgotPasswordService _forgotPasswordService = ForgotPasswordService();
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordScreen({Key? key}) : super(key: key);

  void _getForgotLink(BuildContext context) async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      showErrorSnackbar(context, 'Please enter your email.');
      return;
    }

    RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );

    if (!emailRegex.hasMatch(email)) {
      showErrorSnackbar(context, 'Please enter a valid email.');
      return;
    }

    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sending password reset email...')),
      );

      // Send password reset email using ForgotPasswordService
      await _forgotPasswordService.resetPassword(email);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent successfully.'),
        ),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 160.h,
                decoration: const BoxDecoration(color: Color(0xFFFF9F1C)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SpoonShare',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.sp,
                        fontFamily: 'Lora',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.12,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Nourishing Lives, Creating Smiles!',
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
              SizedBox(height: 30.h),
              const Text(
                'Oops! Forgot your password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Lora',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 250.w,
                child: Text(
                  'Don’t worry we are here to help you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 14.sp,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SvgPicture.asset(
                'assets/images/forgot_password.svg',
                width: 265.w,
                height: 200.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 277,
                child: Text(
                  'Enter your Email associated with your account and we will send you a link to reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 300.w,
                child: InputField(
                  label: "Enter email address",
                  controller: _emailController,
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                buttonText: "Get Link",
                onPressed: () => _getForgotLink(context),
              ),
              SizedBox(height: 20.h),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: 20.h),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don’t have an Account yet? ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'Create an Account',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
