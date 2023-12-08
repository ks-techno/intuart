import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../controller/home_controller.dart';

class LeftMenuClosed extends StatefulWidget {
  final AnimationController animationController;
  final ValueNotifier<int> selectedLeftMenu;
  LeftMenuClosed({
    super.key,
    required this.animationController,
    required this.selectedLeftMenu,
  });

  @override
  State<LeftMenuClosed> createState() => _LeftMenuClosedState();
}

class _LeftMenuClosedState extends State<LeftMenuClosed> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      // top: MediaQuery.of(context).size.height / 2 - 473.h / 2,
      top: MediaQuery.of(context).size.height / 2 - (406.h / 2),
      child: Container(
        width: 76.w,
        height: 393.h,
        decoration: BoxDecoration(
            color: AppColors.fillColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(48.r),
                bottomRight: Radius.circular(48.r))),
        child: Padding(
          padding: EdgeInsets.only(top: 32.h, bottom: 48.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
          
          
                InkWell(
                  onTap: () {
                    print(widget.animationController.value);
                    
                      if (widget.animationController.value == 0) {
              widget.animationController.forward();
            } else {
              widget.animationController.reverse();
                   
            }
                   
                    Get.find<HomeController>().isLeftClicked.toggle();
                  },
                  child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8.r)),
                      child:  Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 17.w),
                        child:
                  Obx(() {
            // Use an observable variable from your controller here
            return homeController.isLeftClicked == false
                ? Icon(Icons.arrow_back_ios, size: 11.h,)
                : Icon(Icons.arrow_forward_ios, size: 11.h);
          })
          
                        
                        
                        //  CustomSvg(
                        //   image:  homeController.selectedLeftMenu.value == 0 ? AppAssets.menuIcon1 : AppAssets.menuIcon1,
                        //   wi: 7.w,
                        //   hi: 11.h,
                        //   color: AppColors.fillColor,
                        // ),
                      )),
                ),
                SizedBox(height: 10.h,),
                Obx(() {
                  return  InkWell(
                onTap: () {
                  // widget.selectedLeftMenu.value = 0;
                  homeController.selectedLeftMenu.value = 0;
                },
                 child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 110.w,
                  height: 55.h,
              
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r),color:homeController.selectedLeftMenu.value == 0 ? AppColors.menuSelectedColor : Colors.transparent ),
                  // ,
                   child: Center(
                     child: Image(
                        image: const AssetImage(
                          AppAssets.shapeIcon,
                        ),
                        height: 27.h,
                        width: 27.w,
                      ),
                   ),
                 ),
               );
                
                }),
              
                
              Obx((){
                
                return  InkWell(
                   onTap: () {
                  homeController.selectedLeftMenu.value = 1;
                },
                
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 110.w,
             height: 55.h,
              
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r),color:homeController.selectedLeftMenu.value == 1 ? AppColors.menuSelectedColor : Colors.transparent ),
                  // ,
                    child: Center(
                      child: Image(
                        image: const AssetImage(
                           AppAssets.colorIcon,
                        ),
                        height: 27.h,
                        width: 27.w,
                      ),
                    ),
                  ),
                ); }),
                Obx(() {
          
                  return   InkWell(
                    onTap: () {
                  homeController.selectedLeftMenu.value = 2;
                },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 110.w,
                height: 55.h,
              
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r),color:homeController.selectedLeftMenu.value == 2 ? AppColors.menuSelectedColor : Colors.transparent ),
                    child: Center(
                      child: Image(
                        image: const AssetImage(
                           AppAssets.sizeIcon,
                        ),
                        height: 27.h,
                        width: 27.w,
                      ),
                    ),
                  ),
                );
              
                }),
               
               Obx(() {
                return  InkWell(
                     onTap: () {
                  homeController.selectedLeftMenu.value = 3;
                },
                  child: Container(
                                 margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 110.w,
                height: 55.h,
              
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r),color:homeController.selectedLeftMenu.value == 3 ? AppColors.menuSelectedColor : Colors.transparent ),
                
                    child: Center(
                      child: Image(
                        image: const AssetImage(
                          AppAssets.actionIcon,
                        ),
                        height: 27.h,
                        width: 27.w,
                      ),
                    ),
                  ),
                );
              
               }),
               Obx(() {
              return    InkWell(
                     onTap: () {
                  homeController.selectedLeftMenu.value = 4;
                },
                  child: Container(
                                       margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 110.w,
                height: 55.h,
              
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r),color:homeController.selectedLeftMenu.value == 4 ? AppColors.menuSelectedColor : Colors.transparent ),
                
                    child: Center(
                      child: Image(
                        image: const AssetImage(
                          AppAssets.exporIcon,
                        ),
                        height: 27.h,
                        width: 27.w,
                      ),
                    ),
                  ),
                );
               })
             
                   
              ],
            ),
          ),
        ),
      ),
    );
  }
}
