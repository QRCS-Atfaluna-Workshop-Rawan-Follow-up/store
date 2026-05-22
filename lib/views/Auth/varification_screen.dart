import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // ضروري لاستدعاء الكنترولر
import 'package:store_app/controllers/auth_controller.dart';
import 'package:store_app/views/Auth/widgets/space_input_format.dart';
import '../../core/theme/app_asset.dart';
import '../../core/theme/app_color.dart';
import '../widgets/store_text.dart';

class Varification extends StatefulWidget {
  const Varification({super.key});

  @override
  State<Varification> createState() => _VarificationState();
}

class _VarificationState extends State<Varification> {
  late final TextEditingController codeController;
  late final GlobalKey<FormState> formKey;

  // الوصول للكنترولر
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // استلام البيانات الممرة (إذا كنتِ تمرين بيانات المستخدم)
    final Map<String, dynamic> userData = Get.arguments ?? {};

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('${AppAsset.imageUrl}back.svg'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.r),
                child: StoreText(
                  // عدلت النص لـ 6 أرقام لأن فايربيس يرسل 6 عادةً
                  value: "Enter your 6-digit code",
                  color: AppColor.titleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: StoreText(
                  value: "Code",
                  color: const Color(0xff7C7C7C),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.w, color: const Color(0xffE2E2E2)),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    maxLength: 121, // فايربيس يرسل 6 أرقام
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6), // الحد الأقصى 6 أرقام
                      SpacedTextInputFormatter(), // المنسق الذي صنعناه
                    ],
                    decoration: const InputDecoration(
                      hintText: "- - - - - -",
                      border: InputBorder.none,
                      counterText: "", // إخفاء العداد

                    ),
                    onChanged: (value) {
                      // يجب حذف المسافات قبل إرسال الكود للتحقق
                      String cleanCode = value.replaceAll(' ', '');

                      if (cleanCode.length == 6) {
                        authController.verifyOtpAndSubmit(cleanCode, Get.arguments ?? {});
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 250.h),
              Padding(
                padding: EdgeInsets.all(10.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // دالة إعادة إرسال الكود
                        if (userData.containsKey('phone')) {
                          authController.sendOtpToPhone(userData['phone']);
                        }
                      },
                      child: StoreText(
                        value: "Resend Code",
                        color: AppColor.mainColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 18.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // التحقق اليدوي عند الضغط على الزر
                        if (codeController.text.length == 6) {
                          authController.verifyOtpAndSubmit(codeController.text, userData);
                        } else {
                          Get.snackbar("تنبيه", "الرجاء إدخال الكود كاملاً");
                        }
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          shape: BoxShape.circle, // جعل الزر دائري بشكل أفضل
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4.r,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: SvgPicture.asset(
                          '${AppAsset.imageUrl}Frame.svg',
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}