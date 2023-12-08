import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    required this.value, this.onChange, required this.maxValue, this.trackHeight, this.inactiveTrackColor
  });

  final dynamic value;
  final dynamic onChange;
  final double maxValue;
  final Color? inactiveTrackColor;
  final double? trackHeight;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: trackHeight ?? 2.h,
        activeTrackColor: AppColors.whiteColor,
        inactiveTrackColor: AppColors.whiteColor,
        thumbColor: AppColors.whiteColor,
        overlayColor: Colors.transparent,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 16.r, elevation: 0),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 16.r),
      ),
      child: Slider(
          min: 0.0,
          max: maxValue,
          value: value,
          onChanged: onChange),
    );
  }
}