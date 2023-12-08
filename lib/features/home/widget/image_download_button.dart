import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/custom_svg.dart';

class ImageDownloadButton extends StatelessWidget {
  const ImageDownloadButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328.w,
      height: 48.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: AppColors.borderColor)),
      child: Padding(
        padding: EdgeInsets.only(left: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSvg(
              image: AppAssets.downloadIcon,
              wi: 16.w,
              hi: 20.h,
            ),
            SizedBox(
              width: 9.w,
            ),
            Text(
              AppStrings.downloadStimulationImage,
              style: AppStyles.interSemiBold(color: AppColors.primaryFontColor),
            )
          ],
        ),
      ),
    );
  }
}
