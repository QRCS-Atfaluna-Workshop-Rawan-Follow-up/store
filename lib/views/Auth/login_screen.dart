import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/routes/app_routes.dart';
import 'package:store_app/views/Auth/signup_screen.dart';
import 'package:store_app/views/Auth/widgets/text_form_field.dart';
import '../../controllers/auth_controller.dart';
import '../../core/theme/app_asset.dart';
import '../../core/theme/app_color.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/store_elevated_btn.dart';
import 'package:get/get.dart';
import '../widgets/store_text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final  authController = Get.find<AuthController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();

  }
  @override
  Widget build(BuildContext context)  {
    return  ScreenUtilInit(
      designSize:Size(414, 896),
      child: Scaffold(
        backgroundColor: Color(0xfffffff),
        body: Padding(
          padding: EdgeInsets.all(20).r,
          child: Column(
            spacing: 15.h,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h,),
              Center(child: SvgPicture.asset("${AppAsset.imageUrl}colorful-carrot.svg")),
              StoreText(value: "Login", color: Color(0xff030303),
                fontWeight: FontWeight.w500, fontSize: 26.sp ,textAlign: TextAlign.start,),
              StoreText(value: "Enter your emails and password",
                color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 13.sp,textAlign: TextAlign.start,),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10.h,
                    children: [
                      StoreText(value: "Email", color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 16.sp),
                      SizedBox(
                        height: 80.h,                        width: 364.w,
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
                        height: 80.h,                        width: 364.w,
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
                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap:() =>  Get.toNamed(AppRoutes.forgetPassword),
                          child: StoreText(value: "Forget Password? ", color: Color(0xff181725), fontWeight:
                          FontWeight.w300, fontSize: 13.sp,
                            textAlign: TextAlign.end,),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(
                height: 55.h,
                width: 364.w,
                child: StoreElevatedBtn(value: "Login",
                  color: AppTheme.btnColor,
                  borderRadius: BorderRadius.circular(12).r,
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      authController.login(
                          email: emailController.text,
                          password: passwordController.text
                      );
                    }
                    // ApiService().login();
                  },),
              ),
              Center(
                child: RichText(
                    text: TextSpan( style: TextStyle(
                        color: Color(0xff3B4054),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400

                    ),
                    children: [
                      TextSpan(text:"Don't have account ? ",style: TextStyle(
                        color: Color(0xff181725),
                      ),
                      ),
                      TextSpan( recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signup(),
                            ),
                          );
                        },
                          text: 'Sign Up',style: TextStyle(color: AppColor.mainColor))
                    ]
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
