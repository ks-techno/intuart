import 'package:final_app/utils/app_colors.dart';
import 'package:final_app/utils/app_strings.dart';
import 'package:final_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_routes.dart';
import '../../../widgets/custom_painter.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.homeScreen);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              // color: const Color(0xffC3C3C3),
              child: CustomPaint(
                painter: DottedScreenPainter(),
              ),
            ),
          ),
          Center(
            child: Text(
              AppStrings.intuart,
              style: AppStyles.primaryBoldStyle(
                size: 96.sp,
                color: AppColors.primaryFontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
