import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors.dart';
import '../widget/layer_widget.dart';


class LayersDetail extends StatelessWidget {
  LayersDetail({Key? key});


  final List<String> layerNumbers = ['5', '4', '3', '2', '1'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225.w,
      height: 348.h,
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12.h),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: layerNumbers.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    LayerWidget(number: layerNumbers[index]),
                    SizedBox(height: 21.h),
                  ],
                );
              },
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
