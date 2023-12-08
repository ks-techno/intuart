import 'package:final_app/features/home/controller/home_controller.dart';
import 'package:final_app/utils/app_assets.dart';
import 'package:final_app/utils/app_strings.dart';
import 'package:final_app/widgets/custom_radio_buttons.dart';
import 'package:final_app/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/cancel_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/dialog_button.dart';

newArtBoardDialog(
    BuildContext context,
    Function clear,
    final ValueNotifier<double> canvasHeight,
    final ValueNotifier<double> canvasWidth) {
  HomeController homeController = HomeController();

  Get.dialog(
    GestureDetector(
      onTap: () {
        AppStyles.focusOut();
      },
      child: Center(
        child: Container(
          width: 881.w,
          height: 543.h,
          decoration: BoxDecoration(
            color: AppColors.fillColor,
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 23.h, left: 29.w, bottom: 61.h),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 27.w,
                          height: 27.h,
                          child: CustomSvg(
                            image: AppAssets.artBoardIcon,
                            wi: 27.w,
                            hi: 27.h,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          AppStrings.createNewArtboard,
                          style: AppStyles.primaryBoldStyle(
                              size: 32.sp, color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 29.w),
                    child: Text(
                      AppStrings.displayColorType,
                      style: AppStyles.interBold(
                          size: 20.sp, color: AppColors.whiteColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 31.h, bottom: 53.h),
                    child: CustomRadioButtons(homeController: homeController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 29.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.artboardSize,
                          style: AppStyles.interBold(
                              size: 20.sp, color: AppColors.whiteColor),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 50.h, bottom: 14.h),
                                  child: Text(
                                    AppStrings.height,
                                    style: AppStyles.interRegular(
                                        size: 20.sp,
                                        color: AppColors.whiteColor),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CustomTextField(
                                      controller:
                                          homeController.height1Controller,
                                    ),

                                    // const CustomDropDownButton(),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      width: 102.w,
                                      height: 42.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.whiteColor,
                                              width: 2.w),
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      child: Text('PX',
                                          style: AppStyles.interMedium(
                                              color: AppColors.whiteColor)),
                                    ),
                                    SizedBox(
                                      width: 58.w,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 50.h, bottom: 14.h),
                                  child: Text(
                                    AppStrings.width,
                                    style: AppStyles.interRegular(
                                        size: 20.sp,
                                        color: AppColors.whiteColor),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CustomTextField(
                                      controller:
                                          homeController.height2Controller,
                                    ),

                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      width: 102.w,
                                      height: 42.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.whiteColor,
                                              width: 2.w),
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      child: Text('PX',
                                          style: AppStyles.interMedium(
                                              color: AppColors.whiteColor)),
                                    ),
                                    // const CustomDropDownButton(),
                                    SizedBox(
                                      width: 58.w,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 109.h),
                        Padding(
                          padding: EdgeInsets.only(right: 13.w, bottom: 17.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CancelButton(
                                height: 43.h,
                                color: Colors.transparent,
                                borderColor: AppColors.whiteColor,
                                fontcolor: AppColors.whiteColor,
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              DialogButton(
                                text: AppStrings.create,
                                width: 149.w,
                                color: AppColors.lightBlueColor,
                                onTap: () {
                                  if (homeController
                                      .height1Controller.text.isNotEmpty) {
                                    canvasHeight.value = double.parse(
                                        homeController.height1Controller.text);
                                  }
                                  if (homeController
                                      .height2Controller.text.isNotEmpty) {
                                    canvasWidth.value = double.parse(
                                        homeController.height2Controller.text);
                                  }

                                  clear();
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
