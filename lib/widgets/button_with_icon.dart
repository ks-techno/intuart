import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import 'custom_svg.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    super.key,
    required this.text,
    this.width,
    this.bottomHeight, this.image,
    this.wi, this.hi, this.height,
    this.color, this.fontColor, this.fontSize, this.iconTextDistance, this.onTap,
  });

  final String text;
  final double? width;
  final double? height;
  final double? wi;
  final double? hi;
  final double? bottomHeight;
  final String? image;
  final Color? color;
  final Color? fontColor;
  final double? fontSize;
  final double? iconTextDistance;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 236.w,
        height: height ?? 48.h,
        margin: EdgeInsets.only(bottom: bottomHeight ?? 32.h),
        decoration: BoxDecoration(
            color: color ?? AppColors.grey22Color,
            borderRadius: BorderRadius.circular(32.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSvg(
              image: image ?? AppAssets.importImage,
              wi: wi ?? 18.w,
              hi: hi ?? 18.h,
              color: AppColors.whiteColor,
            ),
            SizedBox(
              width: iconTextDistance ?? 8.w,
            ),
            Text(
              text,
              style: AppStyles.interSemiBold(
                  color: fontColor ?? AppColors.whiteColor,
                  size: fontSize ?? 16.sp
              ),
            )
          ],
        ),
      ),
    );
  }
}