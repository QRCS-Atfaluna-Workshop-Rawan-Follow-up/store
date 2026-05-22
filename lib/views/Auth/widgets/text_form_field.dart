import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_color.dart';
import '../../widgets/store_text.dart';

class StoreTextFormField extends StatelessWidget {
   StoreTextFormField({
    super.key, required this.Controller,
    this.errorHint,
    this.validator,
     this.obscuringCharacter = '*',
     this.obscureText = false,
    required this.value,
     this.suffixIcon = null, TextInputType? keyboardType,  int maxLines  = 5,
     // this.outlainBorderRadius = BorderRadius.circular(12).r,
  });
  late String value;
  late final  BorderRadius outlainBorderRadius;
   final TextEditingController Controller;
   final Widget? errorHint;
  late Widget? suffixIcon;
  final String? Function(String?)? validator;
  final String obscuringCharacter;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Controller,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hint:StoreText(value: value , color: Color(0xff7C7C7C),
            fontWeight: FontWeight.w300, fontSize: 14.sp),
        contentPadding: EdgeInsetsGeometry.symmetric(vertical: 20.h,
            horizontal:15.w ),
        helperText: " ",
        hintFadeDuration: Duration(seconds: 5),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffE2E2E2),
            ),
            borderRadius: BorderRadius.circular(12).r
        ),
        border:OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffE2E2E2),
            ),
            borderRadius: BorderRadius.circular(12).r
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColor.mainColor
          ),
          borderRadius: BorderRadius.circular(12).r,
        ),
      ),
      validator:validator
    );
  }
}