import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/profile_controller.dart';
import '../../widgets/store_text.dart';

class EditProfileBottomSheet extends StatefulWidget {
  final ProfileController controller;

  const EditProfileBottomSheet({super.key, required this.controller});

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  // تعريف المتحكمات لكل حقل بناءً على متطلبات الدالة في الكنترولر
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    // تهيئة المتحكمات بالبيانات الحالية للمستخدم
    fNameController = TextEditingController(text: widget.controller.currentUser?.firstName);
    lNameController = TextEditingController(text: widget.controller.currentUser?.lastName);
    emailController = TextEditingController(text: widget.controller.currentUser?.email);
    phoneController = TextEditingController(text: widget.controller.currentUser?.phone);
  }

  @override
  void dispose() {
    // تنظيف الذاكرة عند إغلاق القائمة
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // لضمان عدم تداخل الكيبورد مع العناصر عند الكتابة
      padding: EdgeInsets.fromLTRB(25.w, 15.h, 25.w, MediaQuery.of(context).viewInsets.bottom + 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30).r),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // مقبض السحب العلوي (Handle)
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 25.h),
            StoreText(
              value: "Update Profile Information",
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            SizedBox(height: 25.h),

            // الحقول المطلوبة للتعديل
            _buildModernField(fNameController, "First Name", Icons.person_outline),
            SizedBox(height: 15.h),
            _buildModernField(lNameController, "Last Name", Icons.person_outline),
            SizedBox(height: 15.h),
            _buildModernField(emailController, "Email Address", Icons.email_outlined),
            SizedBox(height: 15.h),
            _buildModernField(phoneController, "Phone Number", Icons.phone_android_outlined),

            SizedBox(height: 30.h),
            SizedBox(
              width: 365.w,
              height: 70.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff53B175),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15).r),
                  elevation: 0,
                ),
                onPressed: () {
                  // استدعاء الدالة باستخدام Named Parameters لحل مشكلة الخطأ
                  widget.controller.updateUserName(
                    firstName: fNameController.text.trim(),
                    lastName: lNameController.text.trim(),
                    email: emailController.text.trim(),
                    phoneNumber: phoneController.text.trim(),countryCode: 'ps'
                  );
                  Get.back(); // إغلاق البوتم شيت بعد الحفظ
                },
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h,)
          ],
        ),
      ),
    );
  }

  // ويدجت مساعدة لبناء الحقول لتقليل تكرار الكود
  Widget _buildModernField(TextEditingController controller, String hint, IconData icon) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 15.sp),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF2F3F2),
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xff53B175), size: 20.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15).r,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15).r,
          borderSide: const BorderSide(color: Color(0xff53B175), width: 1),
        ),
      ),
    );
  }
}