import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/views/widgets/store_text.dart';
import '../../controllers/information_controller.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 💡 لجعل التدرج اللوني يبدأ من أعلى الشاشة خلف الـ AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // شفاف ليتناسق مع الخلفية الجديدة
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
          value: "About Us",
          color: const Color(0xff181725),
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // 🎨 تدرج لوني ناعم مستوحى من ألوان الطبيعة والمتجر الفاخر
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffF2F9F5), Color(0xffFFFFFF), Color(0xffF7F9FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GetBuilder<InformationController>(
          init: InformationController(),
          initState: (state) => Get.find<InformationController>().fetchAboutUs(),
          builder: (controller) {

            if (controller.isAboutLoading) {
              return _buildAdvancedShimmer();
            }

            final content = controller.aboutUsContent ;
            if (content.isEmpty) {
              return  Center(
                child: StoreText(value: "No information available",
                    color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16.sp,),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: kToolbarHeight + 50.h), // مسافة أمان أسفل الـ AppBar

                    // 🌟 هالة ضوئية خلف اللوجو لمنحه مظهر براند فخم
                    Container(
                      padding: const EdgeInsets.all(4).r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.mainColor.withValues(alpha: 0.2), width: 2),
                      ),
                      child: Container(
                        height: 95.h,
                        width: 95.w,
                        padding: const EdgeInsets.all(18).r,
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
                        child: SvgPicture.asset(
                          "${AppAsset.imageUrl}colorful-carrot.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    StoreText(
                      value: "Nectar Store",
                      color: const Color(0xff181725),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    StoreText(
                      value: "v1.0.0",
                      color: const Color(0xff7C7C7C).withValues(alpha: 0.7),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 25.h),

                    // 📜 كارت المحتوى العائم (Card Container)
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
                            color: const Color(0xff53575A), // لون مريح جداً للقرائه الطويلة
                            fontWeight: FontWeight.w400,
                            lineHeight: LineHeight.em(1.65),
                            textAlign: TextAlign.justify,
                            padding: HtmlPaddings.only(bottom: 10.h),
                          ),
                          "strong": Style(
                            color: const Color(0xff181725),
                            fontWeight: FontWeight.bold,
                            fontSize: FontSize(16.sp),
                          ),
                          "h2": Style(
                            color: AppColor.mainColor,
                            fontSize: FontSize(17.sp),
                            fontWeight: FontWeight.bold,
                            margin: Margins.only(top: 10.h, bottom: 8.h),
                          ),
                        },
                      ),
                    ),

                    SizedBox(height: 25.h),

                    // 🌟 ميزة التصميم الجديد: بطاقات قيم التطبيق لزيادة الاحترافية
                    _buildFeatureGrid(),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // 🛠️ ودجت جانبية لعرض ميزات المتجر بأسفل الصفحة
  Widget _buildFeatureGrid() {
    return Row(
      spacing: 12.w,
      children: [
        _buildFeatureItem(Icons.eco_outlined, "100% Organic"),
        _buildFeatureItem(Icons.local_shipping_outlined, "Fast Delivery"),
        _buildFeatureItem(Icons.support_agent_outlined, "24/7 Support"),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String title) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(16).r,
          border: Border.all(color: const Color(0xffE2E2E2).withValues(alpha: 0.5)),
        ),
        child: Column(
          spacing: 6.h,
          children: [
            Icon(icon, color: AppColor.mainColor, size: 22.sp),
            StoreText(
              value: title,
              color: const Color(0xff181725),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }

  // 🛠️ شيمر متطور يواكب انحناءات التصميم الجديد
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
            Container(width: 140.w, height: 22.h, color: Colors.white),
            SizedBox(height: 30.h),
            Container(
              width: double.infinity,
              height: 250.h,
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