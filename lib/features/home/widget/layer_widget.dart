import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/custom_svg.dart';

class LayerWidget extends StatelessWidget {
  const LayerWidget({
    super.key,
    required this.number,
  });

  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 201.w,
      height: 48.h,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
          color: AppColors.fileNameColor,
          borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 13.w),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
              child: CustomSvg(
                  image: AppAssets.importIconColored, wi: 20.w, hi: 20.h),
            ),
            Text(
              'Layer $number',
              style: AppStyles.interRegular(
                  size: 20.sp, color: AppColors.blackColor),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomSvg(image: AppAssets.layerIcon, wi: 16.w, hi: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}