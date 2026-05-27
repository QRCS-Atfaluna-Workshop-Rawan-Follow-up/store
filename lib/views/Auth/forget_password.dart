// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:store_app/views/Auth/widgets/text_form_field.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../core/theme/app_asset.dart';
// import '../../core/theme/app_theme.dart';
// import '../../controllers/auth_controller.dart';
// import '../widgets/store_elevated_btn.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:store_app/controllers/auth_controller.dart';
// import '../widgets/store_text.dart';
// import 'package:get/get.dart';
// class ForgetPassword extends StatefulWidget {
//   const ForgetPassword({super.key});
//
//   @override
//   State<ForgetPassword> createState() => _ForgetPasswordState();
// }
//
// class _ForgetPasswordState extends State<ForgetPassword> {
//   final formKey = GlobalKey<FormState>();
//   late final TextEditingController emailController;
//   late final TextEditingController passwordController;
//   final  authController = Get.find<AuthController>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     emailController = TextEditingController();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize:Size(414, 896),
//         child: Scaffold(
//           appBar: AppBar(title: StoreText(value: "Forger Password",
//               color:Color(0xff121212), fontWeight: FontWeight.w500,
//               fontSize: 18.sp),),
//           body: Padding(
//             padding: EdgeInsets.all(20).r,
//             child: Column(
//               spacing: 15.h,
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 25.h,),
//                 Center(child: SvgPicture.asset("${AppAsset.imageUrl}colorful-carrot.svg")),
//                 StoreText(value: "Forget Password", color: Color(0xff030303),
//                   fontWeight: FontWeight.w500, fontSize: 26.sp ,textAlign: TextAlign.start,),
//                 StoreText(value: "Enter your emails to reset your password",
//                   color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 13.sp,textAlign: TextAlign.start,),
//                 Form(
//                     key: formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       spacing: 10.h,
//                       children: [
//                         StoreText(value: "Email", color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 16.sp),
//                         SizedBox(
//                           height: 80.h,                        width: 364.w,
//                           child: StoreTextFormField(value: "Email",
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "Is required";
//                               } else if (!RegExp(
//                                 r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
//                               ).hasMatch(value) && !RegExp(r'^\+?\d{9,15}$').hasMatch(value)) {
//                                 return "Please Enter the correct Email ";
//                               }
//                               return null;
//                             },
//                             Controller: emailController,
//
//                           ),
//                         ),
//                       ],
//                     )
//                 ),
//                 SizedBox(
//                   height: 55.h,
//                   width: 364.w,
//                   child: StoreElevatedBtn(value: "Continue",
//                     color: AppTheme.btnColor,
//                     borderRadius: BorderRadius.circular(12).r,
//                     onPressed: () {
//                       if(formKey.currentState!.validate()){
//                           EasyLoading.show(status: 'Checking email...');
//                           // 1. جلب الإيميل الذي مررناه من صفحة Forgot Password
//                           final String email = Get.arguments['email'];
//
//                           // 2. جلب الكود من حقل الإدخال (مثلاً pinController)
//                           final String code = controller.text.trim();
//
//                           if (code.length == 4) {
//                             // 3. تنفيذ الدالة
//                             authController.verifyOtpCode(email: email, code: code);
//                           } else {
//                             EasyLoading.showError("Please enter the 4-digit code");
//                           }
//                       }
//                       // ApiService().login();
//                     },),
//                 ),
//
//               ],
//             ),
//           ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/utils/app_validator.dart';
import 'package:store_app/views/Auth/widgets/text_form_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../controllers/auth_controller.dart';
import '../../core/theme/app_asset.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/store_elevated_btn.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../widgets/store_text.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffffffff),
        title: StoreText(
          value: "Forgot Password",
          color: const Color(0xff121212),
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              Center(child: SvgPicture.asset("${AppAsset.imageUrl}colorful-carrot.svg")),
              SizedBox(height: 30.h),
              StoreText(
                value: "Forgot Password",
                color: const Color(0xff030303),
                fontWeight: FontWeight.w500,
                fontSize: 26.sp,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10.h),
              StoreText(
                value: "Enter your email to reset your password",
                color: const Color(0xff7C7C7C),
                fontWeight: FontWeight.w300,
                fontSize: 13.sp,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 25.h),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StoreText(
                      value: "Email",
                      color: const Color(0xff7C7C7C),
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                    ),
                    SizedBox(height: 10.h),
                    StoreTextFormField(
                      value: "Email",
                      validator: (value)=> AppValidator.validateEmail(value),
                      Controller: emailController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                height: 55.h,
                width: 364.w,
                child: StoreElevatedBtn(
                  value: "Continue",
                  color: AppTheme.btnColor,
                  borderRadius: BorderRadius.circular(12).r,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      authController.sendForgotPasswordEmail(
                        emailController.text.trim(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
