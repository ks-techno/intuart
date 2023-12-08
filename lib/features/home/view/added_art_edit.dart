import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../widgets/button_with_icon.dart';
import 'added_art.dart';

class AddedArtEdit extends StatelessWidget {
  const AddedArtEdit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 242.w,
              height: 242.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48.r),
                  border: Border.all(color: AppColors.blackColor, width: 4.w)
              ),
              child: AddedArt(),
            ),
            SizedBox(width: 22.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ButtonWithIcon(
                  text: AppStrings.useInPatternMaker,
                  image: AppAssets.menuIconWhite4,
                  width: 252.w,
                  wi: 15.w,
                  hi: 15.h,
                  bottomHeight: 13.h,
                ),
                ButtonWithIcon(
                  text: AppStrings.moveToNewLayer,
                  image: AppAssets.menuIconWhite5,
                  width: 252.w,
                  wi: 15.w,
                  hi: 16.h,
                  bottomHeight: 13.h,
                ),
                ButtonWithIcon(
                  text: AppStrings.deleteThisImage,
                  image: AppAssets.deleteIconWhite,
                  width: 252.w,
                  wi: 13.w,
                  hi: 15.h,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}