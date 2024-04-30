import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spoonshare/screens/donate/donate_food.dart';
import 'package:spoonshare/screens/donate/share_food.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  bool isShareFoodSelected = true;
  bool isDonateFoodSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height + 10.h,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 146.h,
                    decoration: const BoxDecoration(color: Color(0xFFFF9F1C)),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SpoonShare',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontFamily: 'Lora',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.12,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Nourishing Lives, Creating Smiles!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 275.w,
                height: 80.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '“Join Spoon Share”',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Lora',
                        fontWeight: FontWeight.bold,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: 275,
                      child: Text(
                        'Explore nearby food or join us to make a difference!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.800000011920929),
                          fontSize: 14,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 275,
                height: 140,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ShareFoodScreen(),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 108,
                                height: 106,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFFF9F1C),
                                  shape: CircleBorder(),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Image.asset(
                                      "assets/images/share_food.png"),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Share Free Food',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Lora',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 27),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DonateFoodScreen(), 
                                ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 108,
                                height: 106,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFFF9F1C),
                                  shape: CircleBorder(),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Image.asset(
                                      "assets/images/donate_food.png"),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Donate Food',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Lora',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 320.w,
                height: 290.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/girlthinking.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            
            ],
          ),
        ),
      ),
    );
  }
}
