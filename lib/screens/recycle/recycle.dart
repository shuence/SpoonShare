import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spoonshare/l10n/app_localization.dart';
import 'package:spoonshare/screens/recycle/pickup_food.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spoonshare/utils/label_keys.dart';

class RecycleScreen extends StatelessWidget {
  const RecycleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    return Scaffold(
      body: Container(
        padding: MediaQuery.of(context).padding +
            EdgeInsets.symmetric(vertical: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              localization!.translate(LabelKey.recycleeFood)!,
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
              localization.translate(LabelKey.recycleSolgan1)!,
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
              localization.translate(LabelKey.recycleSolgan2)!,
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
             SizedBox(
              width: 284,
              child: Text(
                localization.translate(LabelKey.recycleSlogan3)!,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                    localization.translate(LabelKey.requestPickup)!,
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
