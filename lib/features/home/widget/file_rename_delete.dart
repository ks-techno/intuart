import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/custom_svg.dart';

class FileRenameDelete extends StatelessWidget {
  const FileRenameDelete({
    super.key,
    required this.icon,
    required this.text,
  });

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 258.w,
      height: 53.h,
      decoration: BoxDecoration(
          color: AppColors.lightBlueColor,
          borderRadius: BorderRadius.circular(100.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSvg(
            image: icon,
            wi: 21.w,
            hi: 21.h,
            color: AppColors.whiteColor,
          ),
          SizedBox(
            width: 12.w,
          ),
          Text(
            text,
            style: AppStyles.interRegular(size: 24.sp,color: AppColors.whiteColor),
          )
        ],
      ),
    );
  }
}