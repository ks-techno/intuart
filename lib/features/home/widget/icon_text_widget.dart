import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({
    super.key, required this.icon, required this.text, this.width, this.onTap,
  });

  final IconData icon;
  final String text;
  final double? width;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 179.w,
        height: 48.h,
        decoration: BoxDecoration(
            color: AppColors.fillColor,
            borderRadius: BorderRadius.circular(32.r)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 25.w, color: AppColors.iconColor,),
            SizedBox(width: 12.w),
            Text(text, style: AppStyles.interSemiBold(color: AppColors.whiteColor),)
          ],
        ),
      ),
    );
  }
}