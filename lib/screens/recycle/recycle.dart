import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spoonshare/screens/recycle/pickup_food.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecycleScreen extends StatelessWidget {
  const RecycleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: MediaQuery.of(context).padding +
            EdgeInsets.symmetric(vertical: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'RECYCLE FOOD',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontFamily: 'Lora',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 14.h),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 48.h),
            Text(
              'The Most Reliable & Efficient ',
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 15.sp,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.30,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Waste Disposal Service',
              style: TextStyle(
                color: const Color(0xFF00BE1E),
                fontSize: 20.sp,
                fontFamily: 'Lora',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            SvgPicture.asset(
              'assets/images/recycle.svg',
              width: 298.w,
              height: 179.h,
            ),
            SizedBox(height: 48.h),
            const SizedBox(
              width: 284,
              child: Text(
                'we are committed to providing you with the best waste disposal service. We are reliable, efficient and always on time.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            SizedBox(height: 32.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const RecycleFoodScreen(),
                  ),
                );
              },
              child: Container(
                width: 200.w,
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF06D801),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'REQUEST PICKUP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.95,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
