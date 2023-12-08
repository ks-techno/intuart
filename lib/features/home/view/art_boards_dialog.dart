import 'package:final_app/features/home/view/new_artboard_dialog.dart';
import 'package:final_app/utils/app_assets.dart';
import 'package:final_app/widgets/button_with_icon.dart';
import 'package:final_app/widgets/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/art_board_name.dart';
import '../../../widgets/dialog_button.dart';
import 'edit_art_board_dialog.dart';

artBoardDialog(BuildContext context,final Function clear,  final ValueNotifier<double> canvasHeight,final ValueNotifier<double> canvasWidth) {

  Get.dialog(
    Center(
      child: Container(
        width: 881.w,
        height: 543.h,
        decoration: BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Scaffold(
          
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset:true,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 23.h, left: 27.w, bottom: 30.h, right: 21.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.artBoards,
                      style: AppStyles.primaryBoldStyle(size: 32.sp),
                    ),
                    Row(
                      children: [
                        CancelButton(
                          color: Colors.transparent,
                          text: "Close",
                          borderColor: AppColors.whiteColor,
                          fontcolor: AppColors.whiteColor,
                        ),
                        const SizedBox(width: 10),
                        ButtonWithIcon(
                          onTap: () {
                            newArtBoardDialog(context,  clear,canvasHeight,canvasWidth);
                          },
                          bottomHeight: 0.h,
                            wi: 14.w,
                            hi: 14.h,
                            image: AppAssets.addIcon,
                            text: AppStrings.newArtboard,
                        fontColor: AppColors.whiteColor,
                        color: AppColors.lightBlueColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 27.w),
                child: ArtBoardName(
                  onTap: (){
                    editArtBoardDialog(context);
                  },
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 18.h, right: 21.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DialogButton(
                      text: AppStrings.close,
                      color: AppColors.lightBlueColor,
                      onTap: (){
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


