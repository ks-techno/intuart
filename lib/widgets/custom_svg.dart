import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  final String image;
  final double? wi;
  final double? hi;
  final Color? color;

  const CustomSvg({super.key, required this.image, this.wi, this.hi, this.color});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      height: hi ?? 15.h,
      width: wi?? 15.w,
      color: color ?? Colors.black,
    );
  }
}