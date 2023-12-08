import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/app_styles.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
    this.color,
    this.height,
    this.text,
    this.width,
    this.fontcolor,
    this.borderColor,
  });

  final String? text;
  final double? width;
  final double? height;
  final Color? color;
  final Color? fontcolor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        width: width ?? 148.w,
        height: height ?? 48.h,
        decoration: BoxDecoration(
            color: color ?? AppColors.menuFillColor,
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(
                color: borderColor ?? AppColors.lightBlueColor, width: 2.w)),
        child: Center(
            child: Text(
          text ?? AppStrings.cancel,
          style: AppStyles.interSemiBold(
            color: fontcolor ?? AppColors.lightBlueColor,
          ),
        )),
      ),
    );
  }
}
