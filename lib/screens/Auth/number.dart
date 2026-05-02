import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/screens/Auth/varification.dart';
import 'package:store_app/widgets/store_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Number extends StatefulWidget {
  const Number({super.key});

  @override
  State<Number> createState() => _NumberState();
}

class _NumberState extends State<Number> {
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
    return ScreenUtilInit(
      designSize: Size(414,896),
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          // title: InkWell(onTap: () {
          //   Navigator.pop(context);
          // }, child: SizedBox(
          //   height: 10.h,
          //   width: 10.w,
          //   child: SvgPicture.asset('${AppAsset.imageUrl}back.svg',
          //     ),
          // )),

        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15).r,
                child: StoreText(
                  value: "Enter your mobile number",
                  color: AppColor.titleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w).r,
                child: StoreText(value: "Mobile Number", color: Color(0xff7C7C7C), fontWeight:
                FontWeight.w500, fontSize: 16.sp),
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
              SizedBox(height: 250.h,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) =>
                        Varification(),));
                  },
                      child: Container(
                        width: 60.w,
                        height:60.h ,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          borderRadius: BorderRadius.circular(500).r
                        ),
                        child: SvgPicture.asset('${AppAsset.imageUrl}Frame.svg',
                            color: Color(0xffffffff),
                          alignment: Alignment.center,
                      ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

