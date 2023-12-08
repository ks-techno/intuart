import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/custom_svg.dart';

class FileNameWidget extends StatelessWidget {
  const FileNameWidget({
    super.key,
    this.width,
    this.height,
    this.imageWidth,
    this.imageHeight,
    this.text,
    this.img,
    this.fileImg,
    this.style,
    this.onTap,
  });

  final double? width;
  final double? height;
  final double? imageWidth;
  final double? imageHeight;
  final String? text;
  final String? img;
  final String? fileImg;
  final TextStyle? style;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: width ?? 120.w, //width?? 350.w,
        height: height ?? 120.h, // height ?? 250.h,
        decoration: BoxDecoration(
          color: AppColors.fileNameColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            fileImg == null || fileImg == '' || fileImg == 'null'
                ? CustomSvg(
                    image: img ?? AppAssets.tree,
                    wi: imageWidth ?? 38.w,
                    hi: imageHeight ?? 50.h,
                  )
                : Container(
                    height: height ?? 69.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: DecorationImage(
                            image: FileImage(
                              File(fileImg.toString()),
                            ),
                            fit: BoxFit.fill)),
                    // child: Image(image: FileImage(File(fileImg.toString()),))
                  ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                text ?? AppStrings.fileName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: style ??
                    AppStyles.interRegular(
                        size: 20.sp, color: AppColors.blackColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
