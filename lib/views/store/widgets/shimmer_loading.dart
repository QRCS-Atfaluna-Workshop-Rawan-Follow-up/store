import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      // 💡 درجات الألوان الرمادية المتحركة للوميض
      baseColor: const Color(0xffE0E0E0),
      highlightColor: const Color(0xffF5F5F5),
      child: Container(
        width: 175.w, // 🎯 تم تعديله ليكون متطابقاً مع عرض الكارت الحقيقي تماماً
        padding: const EdgeInsets.all(10).r, // 🎯 نفس الـ padding في الكارت الحقيقي
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h), // 🎯 نفس الـ margin تماماً
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18).r, // 🎯 نفس انحناء الحواف المعتمد (18)
          border: Border.all(color: const Color(0xffE2E2E2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.h, // 🎯 استخدام نفس الـ spacing الحديث بين العناصر العمودية (8.h)
          children: [

            // 1. هيكل محاكاة صورة المنتج (تطابق أبعاد Image.network)
            Center(
              child: Container(
                width: 100.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10).r,
                ),
              ),
            ),

            // 2. هيكل محاكاة اسم المنتج (تطابق حجم ومظهر خط الاسم)
            Container(
              width: 120.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4).r,
              ),
            ),

            // 3. هيكل محاكاة وحدة قياس المنتج (تطابق حجم ومظهر خط الـ Unit مثل 1kg)
            Container(
              width: 60.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4).r,
              ),
            ),

            // 🎯 تم إضافة الـ Spacer ليدفع السعر والزر لأسفل الكارت تماماً مثل التصميم الحقيقي
            const Spacer(),

            // 4. محاكاة السعر وزر الإضافة الـ (+) الأخضر
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // هيكل السعر
                Container(
                  width: 50.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4).r,
                  ),
                ),

                // هيكل حاوية زر الإضافة الدائري/المربع (تطابق أبعاد الـ Container الخاص بالزر)
                Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17).r, // 🎯 نفس انحناء زر الإضافة الحقيقي
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}