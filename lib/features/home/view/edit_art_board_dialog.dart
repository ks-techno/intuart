import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/art_board_name.dart';
import '../../../widgets/button_with_icon.dart';
import 'package:get/get.dart';

editArtBoardDialog(BuildContext context) {
  Get.dialog(
    GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
        width: 400.w,
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 220.w, bottom: 94.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ArtBoardName(),
                    SizedBox(width: 29.w,),
                    Column(
                      children: [
                        ButtonWithIcon(
                          text: AppStrings.rename,
                          image: AppAssets.editIcon,
                          color: AppColors.lightBlueColor,
                          fontColor: AppColors.whiteColor,
                          iconTextDistance: 12.w,
                          bottomHeight: 9.h,
                          fontSize: 24.sp,
                          width: 258.w,
                          height: 53.h,
                          wi: 21.w,
                          hi: 21.h,
                        ),
                        ButtonWithIcon(
                          text: AppStrings.share,
                          image: AppAssets.shareIcon,
                          color: AppColors.lightBlueColor,
                          fontColor: AppColors.whiteColor,
                          iconTextDistance: 12.w,
                          bottomHeight: 9.h,
                          fontSize: 24.sp,
                          width: 258.w,
                          height: 53.h,
                          wi: 21.w,
                          hi: 23.h,
                        ),
                        ButtonWithIcon(
                          text: AppStrings.export,
                          image: AppAssets.exportIcon,
                          color: AppColors.lightBlueColor,
                          fontColor: AppColors.whiteColor,
                          iconTextDistance: 12.w,
                          bottomHeight: 9.h,
                          fontSize: 24.sp,
                          width: 258.w,
                          height: 53.h,
                          wi: 11.6.w,
                          hi: 18.6.h,
                        ),
                        ButtonWithIcon(
                          text: AppStrings.delete,
                          image: AppAssets.deleteIcon,
                          color: AppColors.lightBlueColor,
                          fontColor: AppColors.whiteColor,
                          iconTextDistance: 12.w,
                          bottomHeight: 9.h,
                          fontSize: 24.sp,
                          width: 258.w,
                          height: 53.h,
                          wi: 21.w,
                          hi: 21.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: true,
  );
}