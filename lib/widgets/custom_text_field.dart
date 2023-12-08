import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, this.controller,
        this.onChanged, 
  });

  final dynamic controller;
   final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135.w,
      height: 42.h,
      margin: EdgeInsets.only(right: 12.w),
      child: TextFormField(
      
        controller: controller,
        style: AppStyles.interMedium(color: AppColors.whiteColor),
      
        cursorColor: AppColors.whiteColor,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        decoration: InputDecoration(
      
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.whiteColor, width: 2.w),
            borderRadius: BorderRadius.circular(100.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.whiteColor, width: 2.w),
            borderRadius: BorderRadius.circular(100.r),
          ),
          hintText: '1000',
          hintStyle: AppStyles.interMedium(color: AppColors.sliderTrackColor),
          contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w ),
          
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}