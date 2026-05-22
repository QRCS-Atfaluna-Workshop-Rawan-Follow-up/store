import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:store_app/views/Auth/widgets/text_form_field.dart';
import '../../controllers/information_controller.dart';
import '../../core/theme/app_asset.dart';
import '../../core/theme/app_color.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/store_elevated_btn.dart';
import '../widgets/store_text.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController issueTypeController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    issueTypeController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    issueTypeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  Size(414, 896),
      child: Scaffold(
        extendBodyBehindAppBar:
            true, // امتداد الخلفية المتدرجة الفخمة خلف الـ AppBar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: const Color(0xff181725),
                  size: 16.sp,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // 🎨 نفس التدرج اللوني لتوحيد هوية شاشات المتجر التعريفية والقانونية
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffF2F9F5), Color(0xffFFFFFF), Color(0xffF7F9FA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(
                    height: kToolbarHeight + 40.h,
                  ), // مسافة أمان مريحة أسفل الـ AppBar
                  // 🌟 هالة ضوئية مخصصة خلف شعار المتجر
                  Container(
                    padding: const EdgeInsets.all(4).r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.mainColor.withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                    child: Container(
                      height: 90.h,
                      width: 90.w,
                      padding: const EdgeInsets.all(18).r,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x1A53B175),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        "${AppAsset.imageUrl}colorful-carrot.svg",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),

                  // العناوين العلوية للشاشة باللغة الإنجليزية المعتمدة للرسائل
                  StoreText(
                    value: "Contact Support",
                    color: const Color(0xff181725),
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 6.h),
                  StoreText(
                    value: "Enter your issue and explain it clearly below",
                    color: const Color(0xff7C7C7C),
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25.h),

                  // 📜 كارت الـ Form العائم (Floating Card Container) متناسق مع بقية الشاشات
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24).r,
                      border: Border.all(color: const Color(0xffF2F3F2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12.h,
                        children: [
                          // 1. حقل نوع المشكلة
                          StoreText(
                            value: "Issue Type",
                            color: const Color(0xff181725),
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                          StoreTextFormField(
                            value: "e.g., Payment, Delivery issue",
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Issue type is required";
                              }
                              return null;
                            },
                            Controller: issueTypeController,
                          ),

                          SizedBox(height: 5.h),

                          // 2. حقل شرح وتفاصيل المشكلة مطور ومطابق تماماً للحقل الأول
                          StoreText(
                            value: "Description",
                            color: const Color(0xff181725),
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                          // 💡 استخدام نفس تصميم الـ الـ Field الأول مع إعطائه أسطر متعددة وارتفاع مريح للشرح
                          SizedBox(
                            height: 140
                                .h, // إعطاء ارتفاع كبير ومميز للصندوق ليناسب كتابة الشرح
                            width: double.infinity,
                            child: StoreTextFormField(
                              value: "Write your details here...",
                              maxLines:
                                  5, // 🎯 يسمح بالكتابة لـ 5 أسطر متتالية بنفس الشكل
                              keyboardType: TextInputType
                                  .multiline, // تفعيل الانتقال لسطر جديد من الكيبورد
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Description is required";
                                }
                                return null;
                              },
                              Controller: descriptionController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    height: 60.h,
                    width: 364.w,
                    child: StoreElevatedBtn(
                      value: "Send",
                      color: AppTheme.btnColor,
                      borderRadius: BorderRadius.circular(12).r,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Get.find<InformationController>().submitTicket(
                            subject: issueTypeController.text,
                            description: descriptionController.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
