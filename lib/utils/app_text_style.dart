import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spoonshare/constants/app_constants.dart';

abstract class AppTextStyle {
  static final TextStyle _baseTextStyle = TextStyle(
    fontFamily: 'DM Sans',
    color: AppColors.kBlackColor,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get mediumXXSmall {
    return _baseTextStyle.copyWith(
      fontSize: 16.sp,
      fontWeight: AppFontWeight.outfitMedium,
    );
  }

  static TextStyle get mediumLarge {
    return _baseTextStyle.copyWith(
      fontSize: 48.sp,
      fontWeight: AppFontWeight.outfitMedium,
    );
  }

  static TextStyle get mediumMedium {
    return _baseTextStyle.copyWith(
      fontSize: 36.sp,
      fontWeight: AppFontWeight.outfitMedium,
    );
  }

  static TextStyle get mediumXSmall {
    return _baseTextStyle.copyWith(
      fontSize: 20.sp,
      fontWeight: AppFontWeight.outfitMedium,
    );
  }

  static TextStyle get mediumSmall {
    return _baseTextStyle.copyWith(
      fontSize: 24.sp,
      fontWeight: AppFontWeight.outfitMedium,
    );
  }

  static TextStyle get mediumBase {
    return _baseTextStyle.copyWith(
      fontSize: 32.sp,
      fontWeight: AppFontWeight.outfitMedium,
    );
  }

  static TextStyle get regularXLarge {
    return _baseTextStyle.copyWith(
      fontSize: 20.sp,
      fontWeight: AppFontWeight.outfitRegular,
    );
  }

  static TextStyle get regularLarge {
    return _baseTextStyle.copyWith(
      fontSize: 18.sp,
      fontWeight: AppFontWeight.outfitRegular,
    );
  }

  static TextStyle get regularMedium {
    return _baseTextStyle.copyWith(
      fontSize: 16.sp,
      fontWeight: AppFontWeight.outfitRegular,
    );
  }

  static TextStyle get regularSmall {
    return _baseTextStyle.copyWith(
      fontSize: 12.sp,
      fontWeight: AppFontWeight.outfitRegular,
    );
  }

  static TextStyle get regularXSmall {
    return _baseTextStyle.copyWith(
      fontSize: 10.sp,
      fontWeight: AppFontWeight.outfitRegular,
    );
  }

  static TextStyle get regularBase {
    return _baseTextStyle.copyWith(
      fontSize: 14.sp,
      fontWeight: AppFontWeight.outfitRegular,
    );
  }
}

abstract class AppFontWeight {
  static const FontWeight outfitRegular = FontWeight.w400;
  static const FontWeight outfitMedium = FontWeight.w500;
  static const FontWeight outfitSemiBold = FontWeight.w600;
  static const FontWeight outfitBold = FontWeight.w700;
}

extension TextStyleExtension on TextStyle {
  TextStyle withOpacity(double opacity) {
    return copyWith(color: color!.withOpacity(opacity));
  }

  TextStyle withColor(Color newColor) {
    return copyWith(color: newColor);
  }
}

extension DarkTextThemeExtension on TextStyle {
  TextStyle convertToDark([Color? darkThemeColor]) {
    return copyWith(
      color: darkThemeColor ?? Colors.white,
    );
  }
}

extension FontFamily on TextStyle {
  TextStyle get outfit {
    return copyWith(fontFamily: 'Outfit');
  }
}

extension FontWeightExtension on TextStyle {
  TextStyle get bold {
    return copyWith(fontWeight: AppFontWeight.outfitBold);
  }

  TextStyle get regular {
    return copyWith(fontWeight: AppFontWeight.outfitRegular);
  }

  TextStyle get semiBold {
    return copyWith(fontWeight: AppFontWeight.outfitSemiBold);
  }

  TextStyle get medium {
    return copyWith(fontWeight: AppFontWeight.outfitMedium);
  }
}

extension FixedColorExtension on TextStyle {
  TextStyle get black {
    return withColor(Colors.black);
  }

  TextStyle get white {
    return withColor(Colors.white);
  }
}

extension FontSizeExtension on TextStyle {
  TextStyle get size16 {
    return copyWith(fontSize: 16.sp);
  }

  TextStyle get size12 {
    return copyWith(fontSize: 12.sp);
  }

  TextStyle get size13 {
    return copyWith(fontSize: 13.sp);
  }

  TextStyle get size14 {
    return copyWith(fontSize: 14.sp);
  }

  TextStyle get size18 {
    return copyWith(fontSize: 18.sp);
  }

  TextStyle get size20 {
    return copyWith(fontSize: 20.sp);
  }

  TextStyle get size22 {
    return copyWith(fontSize: 22.sp);
  }

// TextStyle responsiveFont(BuildContext context) {
//   return copyWith(fontSize: fontSize?.toResponsiveHeight(context));
// }
}
