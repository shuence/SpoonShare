// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// abstract class AppTheme {
//   AppTheme._();
//
//   static ThemeData appTheme = ThemeData.light().copyWith(
//       scaffoldBackgroundColor: AppColors.kWhiteColor,
//       appBarTheme: const AppBarTheme(
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: AppColors.kWhiteColor,
//       ),
//       inputDecorationTheme: _inputDecorationTheme,
//       outlinedButtonTheme: _outlinedButtonTheme,
//       elevatedButtonTheme: _elevatedButtonTheme,
//       colorScheme: _colorScheme,
//       textTheme: _textTheme,
//       navigationBarTheme: _navigationBarTheme,
//       bottomNavigationBarTheme: _bottomNavigationBarTheme,
//       textSelectionTheme: _textSelectionTheme);
//
//   static TextSelectionThemeData get _textSelectionTheme =>
//       const TextSelectionThemeData(
//           cursorColor: AppColors.kBlackColor,
//           selectionColor: AppColors.kBaseBrandColor,
//           selectionHandleColor: AppColors.kBaseBrandColor);
//
//   static ColorScheme get _colorScheme => const ColorScheme(
//     brightness: Brightness.light,
//     primary: AppColors.kBaseBrandColor,
//     onPrimary: AppColors.kWhiteColor,
//     secondary: AppColors.kBasePurpleColor,
//     onSecondary: AppColors.kWhiteColor,
//     error: AppColors.kErrorColor,
//     onError: AppColors.kWhiteColor,
//     background: AppColors.kWhiteColor,
//     onBackground: AppColors.kGrey500Color,
//     surface: AppColors.kGrey50Color,
//     onSurface: AppColors.kGrey500Color,
//   );
//
//   static OutlinedButtonThemeData get _outlinedButtonTheme =>
//       OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: AppColors.kBlackColor,
//           fixedSize: const Size(335, 48),
//           padding: EdgeInsets.zero,
//           textStyle: AppTextStyle.mediumXXSmall,
//           disabledForegroundColor: AppColors.kGrey200Color,
//           side: const BorderSide(color: AppColors.kBlackColor),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(100.r),
//           ),
//         ),
//       );
//
//   static NavigationBarThemeData get _navigationBarTheme =>
//       NavigationBarThemeData(
//         labelTextStyle: MaterialStateProperty.all(AppTextStyle.regularBase),
//         backgroundColor: AppColors.kWhiteColor,
//       );
//
//   static BottomNavigationBarThemeData get _bottomNavigationBarTheme =>
//       BottomNavigationBarThemeData(
//         selectedLabelStyle: AppTextStyle.regularXSmall,
//         backgroundColor: AppColors.kWhiteColor,
//       );
//
//   static ElevatedButtonThemeData get _elevatedButtonTheme =>
//       ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.kBlackColor,
//           disabledForegroundColor: AppColors.kGrey200Color,
//           fixedSize: const Size(335, 48),
//           padding: EdgeInsets.zero,
//           textStyle: AppTextStyle.mediumXXSmall,
//           foregroundColor: AppColors.kWhiteColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(100.r),
//           ),
//         ),
//       );
//
//   static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
//     filled: true,
//     fillColor: AppColors.kWhiteColor,
//     suffixIconColor: AppColors.kGrey300Color,
//     contentPadding: EdgeInsets.symmetric(
//       vertical: 16.h,
//       horizontal: 16.w,
//     ),
//     hintStyle:
//     AppTextStyle.regularBase.copyWith(color: AppColors.kGrey200Color),
//     errorStyle:
//     AppTextStyle.regularSmall.copyWith(color: AppColors.kErrorColor),
//     border: OutlineInputBorder(
//       borderSide: BorderSide(
//         width: 1.w,
//         color: AppColors.kGrey200Color,
//       ),
//       borderRadius: BorderRadius.circular(8.r),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         width: 1.w,
//         color: AppColors.kGrey200Color,
//       ),
//       borderRadius: BorderRadius.circular(8.r),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         width: 1.w,
//         color: AppColors.kBlackColor,
//       ),
//       borderRadius: BorderRadius.circular(8.r),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         width: 1.w,
//         color: AppColors.kErrorColor,
//       ),
//       borderRadius: BorderRadius.circular(8.r),
//     ),
//   );
//
//   static TextTheme get _textTheme => TextTheme(
//     displayLarge: AppTextStyle.mediumXXSmall,
//     displayMedium: AppTextStyle.mediumLarge,
//     displaySmall: AppTextStyle.mediumMedium,
//     headlineMedium: AppTextStyle.mediumXSmall,
//     headlineSmall: AppTextStyle.mediumSmall,
//     titleLarge: AppTextStyle.mediumBase,
//     titleMedium: AppTextStyle.regularXLarge,
//     titleSmall: AppTextStyle.regularLarge,
//     bodyLarge: AppTextStyle.regularMedium,
//     bodyMedium: AppTextStyle.regularSmall,
//     labelLarge: AppTextStyle.regularBase,
//   );
// }
