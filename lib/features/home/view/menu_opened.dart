import 'package:final_app/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styles.dart';
import '../controller/home_controller.dart';

class MenuOpened extends StatelessWidget {
  MenuOpened({
    super.key,
  });

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16.w,
      // top: MediaQuery.of(context).size.height / 2 - 393.h / 2,
  top: MediaQuery.of(context).size.height / 2 - (406.h / 2),
      child: Container(
        width: 142.w,
        height: 469.h,
        decoration: BoxDecoration(
            color: AppColors.fillColor,
            borderRadius: BorderRadius.circular(48.r)),
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
                          image: AppAssets.menuIcon01,
                          wi: 7.w,
                          hi: 11.h,
                        ))),
              ),
              Obx(
                () => ExpandedMenuItem(
                  icon: AppAssets.menuIcon2,
                  iconWhite: AppAssets.menuIconWhite2,
                  text: AppStrings.clipBoard,
                  iconWidth: 27.w,
                  iconHeight: 15.h,
                  isSelected: homeController.selectedMenu.value == 1,
                  onTap: () {
                    homeController.selectMenu(1);
                  },
                ),
              ),
              Obx(
                () => ExpandedMenuItem(
                  icon: AppAssets.menuIcon3,
                  iconWhite: AppAssets.menuIconWhite3,
                  text: AppStrings.simulate,
                  iconWidth: 32.w,
                  iconHeight: 32.h,
                  isSelected: homeController.selectedMenu.value == 2,
                  onTap: () {
                    homeController.selectMenu(2);
                  },
                ),
              ),
              Obx(
                () => ExpandedMenuItem(
                  icon: AppAssets.menuIcon4,
                  iconWhite: AppAssets.menuIconWhite4,
                  text: AppStrings.patternMaker,
                  isSelected: homeController.selectedMenu.value == 3,
                  onTap: () {
                    homeController.selectMenu(3);
                  },
                ),
              ),
              Obx(
                () => ExpandedMenuItem(
                  icon: AppAssets.menuIcon5,
                  iconWhite: AppAssets.menuIconWhite5,
                  text: AppStrings.layers,
                  iconWidth: 22.w,
                  isSelected: homeController.selectedMenu.value == 4,
                  onTap: () {
                    homeController.selectMenu(4);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandedMenuItem extends StatelessWidget {
  const ExpandedMenuItem({
    super.key,
    required this.icon,
    required this.text,
    this.iconWidth,
    this.iconHeight,
    required this.isSelected,
    required this.onTap,
    required this.iconWhite,
  });

  final String icon;
  final String iconWhite;
  final String text;
  final double? iconWidth;
  final double? iconHeight;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 110.w,
        height: 75.h,
        decoration: BoxDecoration(
            color:
                isSelected ? AppColors.menuSelectedColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSvg(
                color: AppColors.whiteColor,
                image: isSelected ? iconWhite : icon,
                wi: iconWidth ?? 24.w,
                hi: iconHeight ?? 24.h,
              ),
              SizedBox(
                height: 13.h,
              ),
              Text(
                text,
                style: AppStyles.interRegular(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }


  
}

