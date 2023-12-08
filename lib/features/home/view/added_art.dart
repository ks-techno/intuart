import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_assets.dart';
import '../../../widgets/custom_svg.dart';

class AddedArt extends StatelessWidget {
  const AddedArt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 161.w,
        height: 202.h,
        child: CustomSvg(image: AppAssets.tree, wi: 161.w, hi: 202.h,),),
    );
  }
}