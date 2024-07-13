import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spoonshare/constants/app_images.dart';
import 'package:spoonshare/multilingual.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MultilingualScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(77)),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFFFF9F1C)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenUtil().setWidth(130),
                height: ScreenUtil().setWidth(130),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.spoonShareLogo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Text(
                'SpoonShare',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontFamily: 'Lora',
                  fontWeight: FontWeight.w700,
                  letterSpacing: ScreenUtil().setWidth(0.96),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
              Text(
                'Nourishing Lives, Creating Smiles!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(12),
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
