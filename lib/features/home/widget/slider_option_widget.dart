import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/custom_slider.dart';

class SliderOptionWidget extends StatelessWidget {
  const SliderOptionWidget({
    super.key,
    required this.maxValue,
    required this.value,
    required this.onChange,
    required this.textValue,
  });

  final double maxValue;
  final double value;
  final dynamic onChange;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(43.w, 23.h, 0, 16.h),
          child: Text(
            AppStrings.option1,
            style: AppStyles.interMedium(size: 20.sp,color: AppColors.whiteColor,),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 28.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 163.w,
                child: CustomSlider(
                  maxValue: maxValue,
                  value: value,
                  onChange: onChange,
                ),
              ),
              Container(
                width: 75.w,
                height: 42.h,
                margin: EdgeInsets.only(left: 7.w),
                decoration: BoxDecoration(
                    // color: AppColors.menuFillColor,
                    borderRadius: BorderRadius.circular(100.r),
                    border:
                    Border.all(color: AppColors.whiteColor, width: 2.w)),
                child: Center(
                  child: Text(
                    textValue,
                    style: AppStyles.interMedium(
                      color: AppColors.whiteColor
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24.h,
        )
      ],
    );
  }
}