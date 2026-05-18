import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:store_app/views/widgets/store_text.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../modules/information_controller.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
        ),
        title: StoreText(
          value: "About Us",
          color: const Color(0xff181725),
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: GetBuilder<InformationController>(
        init: InformationController(), // تهيئة المتحكم
        initState: (state) => Get.find<InformationController>().fetchAboutUs(), // جلب البيانات عند الفتح
        builder: (controller) {
          if (controller.isAboutLoading) return CircularProgressIndicator();
          return Html(data: controller.aboutUsContent);
        },
      ),
          // return SingleChildScrollView(
          //   physics:  BouncingScrollPhysics(),
          //   child: Column(
          //     children: [
          //       SizedBox(height: 30.h),
          //       Container(
          //         height: 100.h,
          //         width: 100.w,
          //         decoration: BoxDecoration(
          //           color:  Color(0xffF2F3F2),
          //           shape: BoxShape.circle,
          //         ),
          //         child: Icon(Icons.store, size: 50.sp, color:  Color(0xff53B175)),
          //       ),
          //
          //       Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          //         child: Html(
          //           data: controller?.htmlContent,
          //           style: {
          //             "p": Style(
          //               fontSize: FontSize(15.sp),
          //               color: const Color(0xff7C7C7C),
          //               lineHeight: LineHeight.em(1.5),
          //               textAlign: TextAlign.justify,
          //               padding: HtmlPaddings.only(bottom: 5.h),
          //             ),
          //             "strong": Style(
          //               color: const Color(0xff181725),
          //               fontWeight: FontWeight.bold,
          //               fontSize: FontSize(17.sp),
          //             ),
          //             "body": Style(
          //               margin: Margins.zero,
          //               padding: HtmlPaddings.zero,
          //             ),
          //           },
          //         ),
          //       ),
          //       Divider(color: Colors.grey.shade200, indent: 25.w, endIndent: 25.w),
          //
          //
          //     ],
        //     ),

        // },

    );
  }
}