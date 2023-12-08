import 'package:final_app/features/home/widget/file_name_widget.dart';
import 'package:final_app/features/home/widget/file_rename_delete.dart';
import 'package:final_app/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings.dart';

editClipBoardDialog(BuildContext context) {
  Get.dialog(
    GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
        width: 400.w,
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(right: 125.w, bottom: 200.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FileNameWidget(),
                SizedBox(width: 19.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     const FileRenameDelete(icon: AppAssets.editIcon,
                      text: AppStrings.rename,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const FileRenameDelete(icon: AppAssets.deleteIcon,
                      text: AppStrings.delete,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
    barrierDismissible: true,
  );
}


