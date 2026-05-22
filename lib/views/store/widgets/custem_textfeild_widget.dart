import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // إضافة مسافة جمالية مريحة أسفل كل حقل نصي لمنع التلاصق
      padding: EdgeInsets.only(bottom: 15.h),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffF2F3F2),
          hintText: hint,
          hintStyle: TextStyle(color: const Color(0xff7C7C7C), fontSize: 14.sp),
          // الأيقونة الأمامية باللون الأخضر المميز للتطبيق
          prefixIcon: Icon(icon, color: const Color(0xff53B175), size: 22.sp),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          // إخفاء الحدود الافتراضية المزعجة والاعتماد على الـ BorderRadius
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15).r,
            borderSide: BorderSide.none,
          ),
          // إطار أنيق يظهر باللون الأخضر عند قيام المستخدم بالضغط على الحقل للكتابة
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15).r,
            borderSide: const BorderSide(color: Color(0xff53B175), width: 1.5),
          ),
        ),
      ),
    );
  }
}