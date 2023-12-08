import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors.dart';

class RoundIconWidget extends StatelessWidget {
  const RoundIconWidget({
    super.key, required this.icon, this.onTap,
  });

  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.h,
        margin: EdgeInsets.only(right: 16.w),
        decoration: BoxDecoration(
            color: AppColors.fillColor,
            shape: BoxShape.circle
        ),
        child: Icon(icon, size: 25.w, color: AppColors.iconColor,),
      ),
    );
  }
}