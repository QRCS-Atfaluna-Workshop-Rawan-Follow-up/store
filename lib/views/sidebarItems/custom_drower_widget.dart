import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/views/widgets/store_text.dart';
import '../../../routes/app_routes.dart'; // 💡 تأكدي من مسار الروتس الصحيح عندكِ

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // جعل حواف السايد بار دائرية وناعمة لتناسب الـ UI الفخم
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(30).r,
          bottomRight: const Radius.circular(30).r,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffF2F9F5), Color(0xffFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // 🌟 الجزء العلوي (Header) للـ Drawer يحتوي على اللوجو والبراند
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 60.h, bottom: 30.h, left: 20.w, right: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(30).r,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                spacing: 12.h,
                children: [
                  Container(
                    height: 75.h,
                    width: 75.w,
                    padding: const EdgeInsets.all(14).r,
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F3F2),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColor.mainColor.withValues(alpha: 0.1), width: 1.5),
                    ),
                    child: SvgPicture.asset(
                      "${AppAsset.imageUrl}colorful-carrot.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    spacing: 2.h,
                    children: [
                      StoreText(
                        value: "Nectar Store",
                        color: const Color(0xff181725),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      StoreText(
                        value: "shop@nectar.com",
                        color: const Color(0xff7C7C7C),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // 📜 قائمة العناصر والاتصال بالصفحات الخمسة بالكامل
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                children: [
                  // 1. الصفحة الرئيسية (Home)
                  _buildDrawerItem(
                    icon: Icons.storefront_outlined,
                    title: "Home",
                    onTap: () {
                      Get.back(); // إغلاق السايد بار أولاً
                    },
                  ),

                  _buildDivider(),

                  // 2. صفحة من نحن (About Us)
                  _buildDrawerItem(
                    icon: Icons.info_outline_rounded,
                    title: "About Us",
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.aboutUs);
                    },
                  ),

                  _buildDivider(),

                  // 3. صفحة سياسة الخصوصية (Our Privacy)
                  _buildDrawerItem(
                    icon: Icons.gpp_good_outlined,
                    title: "Our Privacy",
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.privacy);
                    },
                  ),

                  _buildDivider(),

                  // 4. صفحة شروط الاستخدام (Terms & Conditions)
                  _buildDrawerItem(
                    icon: Icons.description_outlined,
                    title: "Terms & Conditions",
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.terms);
                    },
                  ),

                  _buildDivider(),

                  // 5. صفحة الدعم الفني المتناسقة والمعدلة (Customer Support)
                  // ✅ تم نقلها داخل الـ ListView لحماية الشاشة من مشاكل الـ Overflow
                  _buildDrawerItem(
                    icon: Icons.support_agent_rounded, // أيقونة عميل دعم فني أكثر احترافية
                    title: "Customer Support",
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.support); // 💡 روت صفحة الدعم الفني المعدلة
                    },
                  ),
                ],
              ),
            ),

            // 🔐 تذييل الصفحة برقم الإصدار للمتجر
            Padding(
              padding: EdgeInsets.only(bottom: 25.h),
              child: StoreText(
                value: "Version 1.0.0",
                color: const Color(0xff7C7C7C).withValues(alpha: 0.6),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة بناء العناصر بشكل أنيق ومنحني ومتناسق مع هوية المتجر
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12).r,
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xff181725), size: 22.sp),
        title: StoreText(
          value: title,
          color: const Color(0xff181725),
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
        // ✅ تم تعديل الأيقونة إلى سهم يشير للأمام ليناسب التصميم الإنجليزي للمتجر بشكل صحيح
        trailing: Icon(Icons.arrow_forward_ios_rounded, color: const Color(0xff7C7C7C).withValues(alpha: 0.7), size: 14.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12).r),
      ),
    );
  }

  // فاصل ناعم بين العناصر
  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Divider(color: const Color(0xffF2F3F2), height: 1.h),
    );
  }
}