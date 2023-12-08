import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.text,
    this.width,
    this.height,
    this.color,
    this.onTap,
  });

  final String text;
  final double? width;
  final double? height;
  final Color? color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: width ?? 141.w,
            height: height ?? 43.h,
            decoration: BoxDecoration(
                color: color ?? AppColors.grey22Color,
                borderRadius: BorderRadius.circular(32.r)),
            child: Center(
              child: Text(
                text,
                style: AppStyles.interSemiBold(color: AppColors.whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
