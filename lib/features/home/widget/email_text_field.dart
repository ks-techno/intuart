import 'package:final_app/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styles.dart';

class EmailTextField extends StatelessWidget {
  EmailTextField({
    super.key,
  });

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 409.w,
      height: 42.h,
      child: TextFormField(
        controller: homeController.emailController,
        style: AppStyles.interRegular(),
        cursorColor: AppColors.whiteColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.whiteColor, width: 2.w),
            borderRadius: BorderRadius.circular(100.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.whiteColor, width: 2.0),
            borderRadius: BorderRadius.circular(100.r),
          ),
          hintText: AppStrings.enterTheUsersEmailHere,
          hintStyle: AppStyles.interRegular(),
          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}