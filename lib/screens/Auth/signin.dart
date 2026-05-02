import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/screens/Auth/widgets/socail_media_container.dart';
import 'package:store_app/widgets/store_text.dart';
import 'package:country_picker/country_picker.dart';

import 'number.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  Country selectedCountry = Country.parse('PS');
  late final TextEditingController phoneController;
  late final formKey = GlobalKey<FormState>();
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
      body: Padding(
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
                fontSize: 22,
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
                  height: 39.5.h,
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
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.h,
                                    horizontal: 15.w,
                                  ),
                                ),
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
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                      builder: (context) => Number(),));
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
    );
  }
}

