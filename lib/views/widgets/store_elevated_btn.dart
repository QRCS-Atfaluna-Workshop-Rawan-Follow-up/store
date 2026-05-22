import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:store_app/views/widgets/store_text.dart';
import '../../core/theme/app_color.dart';

class StoreElevatedBtn extends StatelessWidget {
  final Color color;
  final BorderRadius borderRadius;
  final String value;
  final VoidCallback onPressed;
  const StoreElevatedBtn({
    super.key,required this.value,required this.color, required this.borderRadius,
   required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,style:
    ElevatedButton.styleFrom(backgroundColor: color,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius
        ),
    ), child: StoreText
      (value: value, color: AppColor.textColor,
        fontWeight: FontWeight.w600, fontSize: 19.sp));
  }
}