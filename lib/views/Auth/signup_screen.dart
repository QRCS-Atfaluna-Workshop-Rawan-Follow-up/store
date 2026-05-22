import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/core/theme/app_theme.dart';
import 'package:store_app/views/Auth/widgets/text_form_field.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../core/localization/storaged_services.dart';
import '../widgets/store_elevated_btn.dart';
import '../widgets/store_text.dart';
import 'login_screen.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  final authController = Get.find<AuthController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize:Size(414, 896),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20).r,
          child: SingleChildScrollView(
            child: Column(
              spacing: 15.h,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h,),
               Center(child: SvgPicture.asset("${AppAsset.imageUrl}colorful-carrot.svg")),
                StoreText(value: "Sign Up", color: Color(0xff030303),
                    fontWeight: FontWeight.w500, fontSize: 26.sp ,textAlign: TextAlign.start,),
                StoreText(value: "Enter your credentials to continue",
                    color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 13.sp,textAlign: TextAlign.start,),
                Form(
                  key: formKey,
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.h,
                  children: [
                    StoreText(value: "Username", color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 16.sp),
                    SizedBox(
                      height: 80.h,
                      width: 364.w,
                      child: StoreTextFormField(value: "Username",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Is required";
                          } else if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
                            return "Name must contain letters";
                          } else {
                            return null;
                          }
                        },
                        Controller: usernameController,
                      ),
                    ),
                      StoreText(value: "Email", color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 16.sp),
                    SizedBox(
                      height: 80.h,
                      width: 364.w,
                      child: StoreTextFormField(value: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Is required";
                          } else if (!RegExp(
                            r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value) && !RegExp(r'^\+?\d{9,15}$').hasMatch(value)) {
                            return "Please Enter the correct Email ";
                          }
                          return null;
                        },
                        Controller: emailController,
            
                      ),
                    ),
                    StoreText(value: "Password", color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 16.sp),
            
                    SizedBox(
                      height: 80.h,
                      width: 364.w,
                      child: StoreTextFormField(value: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Is required";
                          } else if (value.length < 8) {
                            return "Password is weak";
                          } else if (!RegExp(
                            r'[a-zA-Z0-9]',
                          ).hasMatch(value)) {
                            return "Must contains uppercase and lowercase characters";
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        obscuringCharacter: '*',
                        Controller: passwordController,
                      ),
                    ),
                    StoreText(value: "Password", color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 16.sp),
            
                    SizedBox(
                      height: 80.h,
                      width: 364.w,
                      child: StoreTextFormField(value: "Confirm Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Is required";
                          }
                          else if (value != passwordController.text) {
                            return "Password doesn't match";
                          }
                          else {
                            return null;
                          }
                          
                        },
                        obscureText: true,
                        obscuringCharacter: '*',
                        Controller: confirmPasswordController,
                      ),
                    ),
                  ],
                )
                  ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.5,
                      // fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w400,
                      color: Color(0xff7C7C7C),
                    ),
                    children: [
                      TextSpan(text: 'By continuing you agree to our'),
                      TextSpan(
                        text: ' Terms of Service ',
                        style: TextStyle(color: AppColor.mainColor),
                      ),
                      TextSpan(text: 'and'),
                      TextSpan(
                        text: 'and Privacy Policy.',
                        style: TextStyle(color: AppColor.mainColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.h,
                  width: 364.w,
                  child: StoreElevatedBtn(value: "Sign up",
                      color: AppTheme.btnColor,
                    borderRadius: BorderRadius.circular(12).r,
                    onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final storageService = Get.find<StorageService>();

                          // سحب البيانات التي خزنّاها في صفحة الـ Location
                          // String zone = storageService.read('zone') ?? "";
                          // String area = storageService.read('area') ?? "";
                          // سحب الرقم الذي تحققنا منه في صفحة الـ Login
                          String phone = storageService.read('temp_phone') ?? "";

                          // استدعاء الدالة في الـ AuthController
                          authController.signup(
                            firstName: usernameController.text,
                            lastName: 'A',
                            email: emailController.text,
                            phone: phone,
                            password: passwordController.text,
                            passwordConfirmation: confirmPasswordController.text,
                            // address: "$zone, $area", // دمج المنطقة والمدينة كعنوان
                          );
                        }
            
                      },),
                ),
                Center(child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Color(0xff3B4054),
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(text: 'Do you have account? '),
                      TextSpan(
                        text: 'Sign In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                        style: TextStyle(color: AppColor.mainColor),
                      ),
                    ],
                  ),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


