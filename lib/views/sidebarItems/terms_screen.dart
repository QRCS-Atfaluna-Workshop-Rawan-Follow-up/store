import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:store_app/views/widgets/store_text.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../modules/information_controller.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});
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
          value: "Our Terms and Conditions",
          color: const Color(0xff181725),
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: GetBuilder<InformationController>(
        init: InformationController(), // تهيئة المتحكم
        initState: (state) => Get.find<InformationController>().fetchTerms(), // جلب البيانات عند الفتح
        builder: (controller) {
          if (controller.isTermsLoading) return Center(child: CircularProgressIndicator());
          return SingleChildScrollView(child: Html(data: controller.termsContent));
        },
      ),

    );
  }
}