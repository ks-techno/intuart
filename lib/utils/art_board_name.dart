import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_svg.dart';
import 'app_assets.dart';
import 'app_colors.dart';
import 'app_strings.dart';
import 'app_styles.dart';

class ArtBoardName extends StatelessWidget {
  const ArtBoardName({
    super.key, this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 226.w,
        height: 240.h,
        decoration: BoxDecoration(
            color: AppColors.menuSelectedColor,
            borderRadius: BorderRadius.circular(24.r)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 117.w,
              height: 117.h,
              margin: EdgeInsets.only(top: 30.h, bottom: 36.h),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(24.r)
              ),
              child: Padding(
                padding: EdgeInsets.all(16.4.r),
                child: CustomSvg(image: AppAssets.artBoardIcon, wi: 84.w, hi: 84.h),
              ),
            ),
            Text(AppStrings.name, style: AppStyles.interSemiBold(size: 24.sp,color: AppColors.whiteColor),)
          ],
        ),
      ),
    );
  }
}