import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_svg.dart';
import '../controller/home_controller.dart';

class MenuClosed extends StatelessWidget {
  MenuClosed({
    super.key,
  });

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      // top: MediaQuery.of(context).size.height / 2 - 393.h / 2,
  top: MediaQuery.of(context).size.height / 2 - (406.h / 2),    
      child: Container(
        width: 76.w,
        height: 393.h,
        decoration: BoxDecoration(
            color: AppColors.fillColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(48.r),
                bottomLeft: Radius.circular(48.r))),
        child: Padding(
          padding: EdgeInsets.only(top: 32.h, bottom: 48.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.find<HomeController>().isClicked.toggle();
                  homeController.selectedMenu.value = 0;
                },
                child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 14.h, horizontal: 17.w),
                      child: CustomSvg(
                        image: AppAssets.menuIcon1,
                        wi: 7.w,
                        hi: 11.h,
                        color: AppColors.fillColor,
                      ),
                    )),
              ),
              CustomSvg(
                image: AppAssets.menuIcon2,
                wi: 27.w,
                hi: 14.h,
                color: AppColors.whiteColor,
              ),
              CustomSvg(
                image: AppAssets.menuIcon3,
                wi: 22.w,
                hi: 27.h,
                color: AppColors.whiteColor,
              ),
              CustomSvg(
                image: AppAssets.menuIcon4,
                wi: 24.w,
                hi: 24.h,
                color: AppColors.whiteColor,
              ),
              CustomSvg(
                image: AppAssets.menuIcon5,
                wi: 23.w,
                hi: 24.h,
                color: AppColors.whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


