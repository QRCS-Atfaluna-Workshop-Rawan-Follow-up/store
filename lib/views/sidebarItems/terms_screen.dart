import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/views/widgets/store_text.dart';
import '../../controllers/information_controller.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 💡 لجعل التدرج اللوني الفخم يبدأ من أعلى الشاشة خلف الـ AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // شفاف تماماً ليتناسق مع الخلفية المتدرجة
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  )
                ]
            ),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios_new, color: const Color(0xff181725), size: 16.sp),
            ),
          ),
        ),
        title: StoreText(
          value: "Terms & Conditions", // 🎯 تم اختصار العنوان قليلاً ليكون متناسقاً ولا يتداخل في الشاشات الصغيرة
          color: const Color(0xff181725),
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // 🎨 نفس التدرج اللوني الناعم الفاخر لتوحيد هوية شاشات المتجر الثلاث (من نحن - الخصوصية - الشروط)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffF2F9F5), Color(0xffFFFFFF), Color(0xffF7F9FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GetBuilder<InformationController>(
          init: InformationController(),
          initState: (state) => Get.find<InformationController>().fetchTerms(), // جلب بيانات شروط الاستخدام عند فتح الشاشة
          builder: (controller) {

            // ⏳ 1. حالة التحميل: الشيمر المتطور المخصص المتناسق مع أبعاد الكارت العائم
            if (controller.isTermsLoading) {
              return _buildAdvancedShimmer();
            }

            final content = controller.termsContent ;
            if (content.isEmpty) {
              return  Center(
                child: StoreText(value: "No terms available",
                  color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18.sp,),
              );
            }

            // ✅ 2. حالة النجاح: عرض كارت شروط الاتفاقية العائم الفاخر
            return SingleChildScrollView(
              physics:  BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: kToolbarHeight + 50.h), // مسافة أمان مريحة أسفل الـ AppBar

                    // 📜 هالة ضوئية مخصصة لأيقونة وثيقة شروط الاستخدام
                    Container(
                      padding: const EdgeInsets.all(4).r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.mainColor.withValues(alpha: 0.2), width: 2),
                      ),
                      child: Container(
                        height: 95.h,
                        width: 95.w,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1A53B175),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]
                        ),
                        child: Icon(
                          Icons.description_outlined, // أيقونة وثيقة الشروط والبنود الرسمية
                          color: AppColor.mainColor,
                          size: 42.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    StoreText(
                      value: "Terms of Service",
                      color: const Color(0xff181725),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    StoreText(
                      value: "Please read carefully",
                      color: const Color(0xff7C7C7C).withValues(alpha: 0.7),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 25.h),

                    // 📜 كارت المحتوى العائم الفاخر (Floating Glass Card) لحماية وقراءة نصوص البنود
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.r),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24).r,
                          border: Border.all(color: const Color(0xffF2F3F2)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            )
                          ]
                      ),
                      child: Html(
                        data: content,
                        style: {
                          "body": Style(
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                          ),
                          "p": Style(
                            fontSize: FontSize(14.5.sp),
                            color: const Color(0xff53575A), // خط مريح جداً للقراءة والبنود الطويلة
                            fontWeight: FontWeight.w400,
                            lineHeight: LineHeight.em(1.65),
                            textAlign: TextAlign.justify,
                            padding: HtmlPaddings.only(bottom: 12.h),
                          ),
                          "strong": Style(
                            color: const Color(0xff181725),
                            fontWeight: FontWeight.bold,
                            fontSize: FontSize(15.sp),
                          ),
                          "h2": Style(
                            color: AppColor.mainColor, // تلوين العناوين والبنود القانونية بلون المتجر الأساسي
                            fontSize: FontSize(17.sp),
                            fontWeight: FontWeight.bold,
                            margin: Margins.only(top: 12.h, bottom: 8.h),
                          ),
                          "ol": Style(
                            padding: HtmlPaddings.only(left: 15.w, bottom: 10.h),
                          ),
                          "ul": Style(
                            padding: HtmlPaddings.only(left: 15.w, bottom: 10.h),
                          ),
                          "li": Style(
                            fontSize: FontSize(14.sp),
                            color: const Color(0xff53575A),
                            lineHeight: LineHeight.em(1.5),
                            padding: HtmlPaddings.only(bottom: 4.h),
                          ),
                        },
                      ),
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // 🛠️ شيمر متطور لصفحة الشروط يطابق تماماً حجم وانحناءات الهيكل الجديد
  Widget _buildAdvancedShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color(0xffE8EBE9),
      highlightColor: const Color(0xffF4F6F5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + 50.h),
            Container(
              height: 95.h,
              width: 95.w,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            ),
            SizedBox(height: 15.h),
            Container(width: 160.w, height: 22.h, color: Colors.white),
            SizedBox(height: 30.h),
            Container(
              width: double.infinity,
              height: 380.h, // كارت محاكاة لنصوص الشروط الطويلة
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24).r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}