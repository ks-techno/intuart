import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/cancel_button.dart';
import '../../../widgets/dialog_button.dart';
import '../controller/home_controller.dart';
import '../widget/email_text_field.dart';

liveShareDialog(BuildContext context) {
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
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 23.h, left: 27.w, bottom: 61.h),
                    child: Text(
                      AppStrings.liveShare,
                      style: AppStyles.primaryBoldStyle(size: 32.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 29.w),
                    child: Text(
                      AppStrings.inviteViaEmail,
                      style: AppStyles.interBold(
                        size: 20.sp,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 14.h, left: 27.w, bottom: 32.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EmailTextField(),
                        SizedBox(
                          width: 13.w,
                        ),
                        DialogButton(
                          onTap: () {
                            final HomeController homeController =
                                Get.put(HomeController());
                            homeController.emailController.clear();
                          },
                          text: AppStrings.invite,
                          color: AppColors.lightBlueColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 29.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.invitedUsers,
                          style: AppStyles.interBold(
                            size: 20.sp,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'example@example.com',
                              style: AppStyles.interRegular(
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SizedBox(
                              width: 23.w,
                            ),
                            CancelButton(
                              width: 100.w,
                              height: 33.h,
                              text: AppStrings.remove,
                              color: Colors.transparent,
                              fontcolor: AppColors.whiteColor,
                              borderColor: AppColors.whiteColor,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 204.h, bottom: 18.h, right: 21.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CancelButton(
                          width: 215.w,
                          height: 43.h,
                          text: AppStrings.copyInviteLink,
                          color: Colors.transparent,
                          fontcolor: AppColors.whiteColor,
                          borderColor: AppColors.whiteColor,
                        ),
                        SizedBox(width: 17.w),
                        DialogButton(
                          text: AppStrings.done,
                          color: AppColors.lightBlueColor,
                        )
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
