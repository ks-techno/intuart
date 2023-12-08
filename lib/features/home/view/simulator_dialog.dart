import 'package:final_app/utils/app_assets.dart';
import 'package:final_app/utils/app_strings.dart';
import 'package:final_app/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/dialog_button.dart';
import '../widget/image_download_button.dart';

simulatorDialog() {
  Get.dialog(
    Center(
      child: Container(
        width: 1063.w,
        height: 693.h,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Scaffold(
          backgroundColor: AppColors.fillColor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 23.h),
                  child: Text(AppStrings.patternSimulator, style: AppStyles.primaryBoldStyle(size: 32.sp),),
                ),
                Center(
                  child: Container(
                    width: 755.w,
                    height: 507.h,
                    decoration: BoxDecoration(
                      color: AppColors.dialogImageColor,
                      borderRadius: BorderRadius.circular(32.r)
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Center(child: Image.asset(AppAssets.simulationImage, width: 355.w, height: 207.h)),
                        Padding(
                          padding: EdgeInsets.only(left: 17.w, right: 17.w, bottom: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ImageDownloadButton(),
                              Row(
                                children: [
                                  CustomSvg(image: AppAssets.backArrow, wi: 41.w, hi: 41.h),
                                  SizedBox(width: 28.w),
                                  CustomSvg(image: AppAssets.forwardArrow, wi: 41.w, hi: 41.h),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h, right: 13.w, bottom: 14.h),
                  child: DialogButton(
                    text: AppStrings.close,
                    onTap: (){
                      Get.back();
                    },
                    color: AppColors.lightBlueColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}




