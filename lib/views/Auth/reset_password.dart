import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:store_app/core/utils/app_validator.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/store_text.dart';
class ResetPassword extends StatefulWidget{
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}
class _ResetPasswordState extends State<ResetPassword>{
  final keyForm = GlobalKey<FormState>();
  late  TextEditingController passwordController;
  late  TextEditingController emailController;
  late  TextEditingController confirmPasswordController;
  final authController = Get.find<AuthController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
      designSize:Size(414, 896),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffffffff),
          title: StoreText(value: "Reset Password",
            color:Color(0xff121212), fontWeight: FontWeight.w500,
            fontSize: 18.sp),),
        backgroundColor: Color(0xffffffff),
        body:
        Padding(
          padding: const EdgeInsets.all(15).r,
          child: Column(
            spacing: 15.h,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  spacing: 10.h,
                  children: [
                    SvgPicture.asset("${AppAsset.imageUrl}colorful-carrot.svg",width: 70.w,height: 70.h,),
                    Text("Reset Password",style: TextStyle(
                      fontSize: 32.sp,
                      color: AppColor.mainColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins-SemiBold",
                    ),),
                    Text("It was popularised in the 1960s with the release of "
                        "Letraset sheets containing Lorem Ipsum.",textAlign:TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 14.sp,
                        color: Color(0xff61677D),
                        fontWeight: FontWeight.w400,
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Form(
                  key: keyForm,
                  child: Column(
                    spacing:15.h,
                    children: [
                      SizedBox(
                        width: 365.w,
                        child: TextFormField(
                          controller: passwordController,
                          obscuringCharacter: '*',
                          obscureText: true,
                          decoration: InputDecoration(
                            hint: Text("Password",style: TextStyle(color: Color(0xff7C8BA0),fontSize: 16.sp),),
                            suffixIcon: Icon(Icons.visibility_off_outlined,color: Color(0xff7C8BA0),),
                            filled: true,
                            fillColor: Color(0xffF5F9FE),
                            contentPadding: EdgeInsets.symmetric(vertical: 20.w,horizontal: 15.h),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14).r,
                                borderSide: BorderSide.none
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14).r,
                              borderSide: BorderSide(
                                  color:Colors.red
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14).r,
                              borderSide: BorderSide(
                                color: AppColor.mainColor,
                              ),
                            ),
                          ),
                          validator: (value) => AppValidator.validatePassword(value),
                        ),
                      ),
                      SizedBox(
                        width: 365.w,
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscuringCharacter: '*',
                          obscureText: true,
                          decoration: InputDecoration(
                            hint: Text(" Confirm Password",style: TextStyle(color: Color(0xff7C8BA0),fontSize: 16.sp),),
                            suffixIcon: Icon(Icons.visibility_off_outlined,color: Color(0xff7C8BA0),),
                            filled: true,
                            fillColor: Color(0xffF5F9FE),
                            contentPadding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 15.w),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14).r,
                                borderSide: BorderSide.none
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14).r,
                              borderSide: BorderSide(
                                  color:Colors.red
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14).r,
                              borderSide: BorderSide(
                                color: AppColor.mainColor,                              ),
                            ),
                          ),
                          validator: (value)=>AppValidator.validateConfirmPassword(value, confirmPasswordController.text),
                        ),
                      ),
                      SizedBox(height: 5.h,),


                    ],
                  )
              ),
              SizedBox(
                height: 60.h,
                width: 345.w,
                child: ElevatedButton(
                  onPressed: () async {
                    if (keyForm.currentState!.validate()) {
                      // 1. استلام الـ arguments وتجهيزها
                      final dynamic args = Get.arguments;
                      String email = "";
                      String otp = "";
                      // 2. التحقق من نوع البيانات المرسلة لتجنب الخطأ
                      if (args is Map) {
                        email = args['email'] ?? "";
                        otp = args['token'] ?? "";
                      } else {
                        email = args.toString();
                      }

                      authController.resetPassword(
                        email: email,
                        otpToken: otp,
                        newPassword: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                      );
                    }
                  },
                  style:ElevatedButton.styleFrom(
                    backgroundColor: AppColor.mainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14).r
                    )
                ),  child: Text("Submit",style: TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp
                ),
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}