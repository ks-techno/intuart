import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_assets.dart';
import 'app_colors.dart';

class AppStyles {

  static TextStyle primaryBoldStyle({double? size, Color? color,
    double? letterSpacing, List<Shadow>? shadow}){
    return TextStyle(
        fontSize: size ?? 16.sp,
        fontWeight: FontWeight.w400,
        fontFamily: AppAssets.primaryFont,
        color: color ?? AppColors.whiteColor,
        letterSpacing: letterSpacing,
        shadows: shadow
    );
  }

  static TextStyle interBold({double? size, Color? color,
    double? letterSpacing,}){
    return TextStyle(
      fontSize: size ?? 16.sp,
      fontWeight: FontWeight.w700,
      fontFamily: AppAssets.interFont,
      color: color ?? AppColors.blackColor,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle interSemiBold({double? size, Color? color,
    double? letterSpacing,}){
    return TextStyle(
        fontSize: size ?? 16.sp,
        fontWeight: FontWeight.w600,
        fontFamily: AppAssets.interFont,
        color: color ?? AppColors.blackColor,
        letterSpacing: letterSpacing,
    );
  }

  static TextStyle interMedium({double? size, Color? color,
    double? letterSpacing,}){
    return TextStyle(
      fontSize: size ?? 16.sp,
      fontWeight: FontWeight.w500,
      fontFamily: AppAssets.interFont,
      color: color ?? AppColors.blackColor,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle interRegular({double? size, Color? color,
    double? letterSpacing,}){
    return TextStyle(
      fontSize: size ?? 12.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppAssets.interFont,
      color: color ?? AppColors.iconColor,
      letterSpacing: letterSpacing,
    );
  }

  static focusOut () =>
      FocusManager.instance.primaryFocus?.unfocus();

}