import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownField extends StatelessWidget {
  final String? value;
  final String hintText; // 💡 جعلنا الـ Hint نصاً مرناً
  final IconData? icon;  // 💡 الأيقونة الأمامية اختيارية (Null-able)
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator; // 💡 إضافة ميزة التحقق من المدخلات

  const CustomDropdownField({
    super.key,
    required this.value,
    required this.hintText,
    this.icon,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      // تأكدي من عدم استخدام initialValue مع الـ value في نفس الوقت لأن فلوتر يمنع ذلك
      hint: Text(
          hintText,
          style: TextStyle(color: const Color(0xff7C7C7C), fontSize: 16.sp, fontWeight: FontWeight.w300)
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xff7C7C7C)),
      validator: validator, // تفعيل الـ Validator هنا
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF2F3F2),
        // عرض الأيقونة الأمامية فقط إذا تم تمريرها (مثل شاشة الحساب) وإخفاؤها إذا لم تُمرر (مثل شاشة اختيار الموقع)
        prefixIcon: icon != null ? Icon(icon, color: const Color(0xff53B175), size: 22.sp) : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15).r,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15).r,
          borderSide: const BorderSide(color: Color(0xff53B175), width: 1.5),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}