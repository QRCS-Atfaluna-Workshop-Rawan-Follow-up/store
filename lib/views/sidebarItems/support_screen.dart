import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/modules/auth_controller.dart';
import 'package:store_app/routes/app_routes.dart';
import 'package:store_app/views/Auth/signup_screen.dart';
import 'package:store_app/views/Auth/widgets/text_form_field.dart';
import '../../core/theme/app_asset.dart';
import '../../core/theme/app_color.dart';
import '../../core/theme/app_theme.dart';

import '../../modules/information_controller.dart';
import '../widgets/store_elevated_btn.dart';
import 'package:get/get.dart';
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
  final  authController = Get.find<AuthController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    issueTypeController = TextEditingController();
    descriptionController = TextEditingController();

  }
  @override
  Widget build(BuildContext context)  {
    return  ScreenUtilInit(
      designSize:Size(414, 896),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20).r,
          child: Column(
            spacing: 20.h,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 40.h,),
              Center(child: SvgPicture.asset("${AppAsset.imageUrl}colorful-carrot.svg")),
              StoreText(value: "Contact with  Support team", color: Color(0xff030303),
                fontWeight: FontWeight.w500, fontSize: 26.sp ,textAlign: TextAlign.start,),
              StoreText(value: "Enter your issue and explain in description box",
                color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 13.sp,textAlign: TextAlign.start,),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10.h,
                    children: [
                      StoreText(value: "Issue Type", color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 16.sp),
                      SizedBox(
                        height: 80.h,                        width: 364.w,
                        child: StoreTextFormField(value: "Issue Type",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Is required";
                            }
                            return null;
                          },
                          Controller: issueTypeController,

                        ),
                      ),
                      StoreText(value: "Description", color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 16.sp),
                      SizedBox(
                        height: 80.h,                        width: 364.w,
                        child: StoreTextFormField(value: "Description",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Is required";
                            }
                              return null;
                          },
                          Controller: descriptionController,
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(
                height: 55.h,
                width: 364.w,
                child: StoreElevatedBtn(value: "Send",
                  color: AppTheme.btnColor,
                  borderRadius: BorderRadius.circular(12).r,
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                     Get.find<InformationController>().submitTicket(
                         subject: issueTypeController.text,
                         description: descriptionController.text,
                     );
                    }
                    // ApiService().login();
                  },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
