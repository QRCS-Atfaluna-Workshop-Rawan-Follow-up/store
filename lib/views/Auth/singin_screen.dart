import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/controllers/auth_controller.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/views/Auth/widgets/socail_media_container.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';

import '../widgets/store_text.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  Country selectedCountry = Country.parse('PS');
  late final TextEditingController phoneController;
  late final formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            spacing: 10.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "${AppAsset.imageUrl}signup-bg.png",
                fit: BoxFit.cover,
                width: 413.w,
                height: 365.h,
              ),
              Padding(
                padding: EdgeInsets.all(15).r,
                child: StoreText(
                  value: "Get your groceries \n with nectar",
                  color: AppColor.titleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    searchAutofocus: true,
                    onSelect: (Country country) {
                      setState(() {
                        selectedCountry = country;
                      });
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(15).r,
                  child: Container(
                    width: 364.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2.w, color: Color(0xffE2E2E2)),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                        horizontal: 15.w,
                      ),
                      child: Row(
                        spacing: 15.w,
                        children: [
                          Text(
                            selectedCountry.flagEmoji,
                            style: TextStyle(fontSize: 28.sp),
                          ),
                          Text(
                            "+${selectedCountry.phoneCode}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Form(
                              key: formKey,
                              child: SizedBox(
                                height: 50.h,
                                width: double.infinity,
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    hint: Text("- - - - "),
                                    border: InputBorder.none,
                                    counterText: "",
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                      horizontal: 15.w,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    // إذا وصل الرقم لـ 10 خانات
                                    if (value.length == 10) {
                                      // إذا كان الرقم يبدأ بـ 0، نقوم بحذف الصفر وإضافة كود الدولة
                                      String formattedNumber = value.startsWith('0') ? value.substring(1) : value;
                                      String fullPhone = "+${selectedCountry.phoneCode}$formattedNumber";

                                      authController.sendOtpToPhone(fullPhone);
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter phone number";
                                      }

                                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                        return "Enter valid phone number";
                                      }
                                      return null;
                                    },

                                  onTap: () {

                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: StoreText(
                  value: "or connect with social media",
                  color: Color(0xff828282),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                child: SocialMediaContainer(containerColor: Color(0xff5383EC),
                  value: "Continue with Google",
                  imageSrc: '${AppAsset.imageUrl}google.svg',),
              ),
              InkWell(
                child: SocialMediaContainer(containerColor: Color(0xff4A66AC),
                  value: "Continue with FaceBook",
                  imageSrc: '${AppAsset.imageUrl}facebook.svg',),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

