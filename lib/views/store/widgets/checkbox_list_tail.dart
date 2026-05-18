import 'package:flutter/material.dart';

import '../../../core/theme/app_color.dart';
import '../../../widgets/store_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckboxListTileWidget extends StatelessWidget {
  const CheckboxListTileWidget({
    super.key, required this.text, this.value = false, required this.onChanged,
  });
  final String text ;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      child: CheckboxListTile(
        title:
      StoreText(value:text , color: Color(0xff121212),
          fontWeight: FontWeight.w300, fontSize: 13.sp),
        onChanged: onChanged, value: value,
        checkColor: AppColor.textColor,
        activeColor: AppColor.mainColor,
        controlAffinity: ListTileControlAffinity.leading,
        visualDensity: VisualDensity.compact,
        side: BorderSide(
          color: Color(0xFFC2C2C2),
          width: 1.w,
        ),
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5).r
        ) ,
      ),
    );
  }
}