import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  final List<String> items = [
    'PT',
    'PC',
    'IN',
    'CM',
    'MM'
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          enableFeedback: false,
          
            isExpanded: false,
            iconStyleData: IconStyleData(
              iconEnabledColor: AppColors.whiteColor
            ),
            hint: Text(
                'PX',
                style: AppStyles.interMedium(color: AppColors.whiteColor)
            ),
            items: items
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                  item,
                  style: AppStyles.interMedium(color: AppColors.whiteColor)
              ),
            ))
                .toList(),
            value: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
            },
            buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                width: 102.w,
                height: 42.h,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.whiteColor, width: 2.w),
                    borderRadius: BorderRadius.circular(8.r)
                )
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
      );
  }
}
