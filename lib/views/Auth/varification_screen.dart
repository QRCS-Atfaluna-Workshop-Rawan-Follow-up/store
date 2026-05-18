import 'package:flutter/material.dart';
 import 'package:country_picker/country_picker.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_asset.dart';
import '../../core/theme/app_color.dart';
import '../../widgets/store_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'location_screen.dart';

class Varification extends StatefulWidget {
  const Varification({super.key});

  @override
  State<Varification> createState() => _VarificationState();
}

class _VarificationState extends State<Varification> {
  late final TextEditingController codeController;
  late final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeController = TextEditingController();
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
                  value: "Enter your 4-digit code",
                  color: AppColor.titleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: StoreText(value: "Code", color: Color(0xff7C7C7C), fontWeight:
                FontWeight.w500, fontSize: 16.sp),
              ), Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 2.w, color: Color(0xffE2E2E2)),
                    ),
                  ),
                child: Form(
                    key: formKey,
                    child: SizedBox(
                      height: 40.h,
                      width: double.infinity,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: codeController,
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
                SizedBox(height: 250.h,),
                Padding(
                  padding: EdgeInsets.all(10).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StoreText(value: "Resend Code", color: AppColor.mainColor,
                          fontWeight: FontWeight.w300, fontSize: 18.sp),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          Location(),));
                        },
                        child: Container(
                          width: 60.w,
                          height:55.h ,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.mainColor,
                              borderRadius: BorderRadius.circular(200).r,
                          border: Border(
                          bottom: BorderSide(width: 2.w, color: Color(0xffE2E2E2)),),
                          ),
                          child: SvgPicture.asset('${AppAsset.imageUrl}Frame.svg',
                            color: Color(0xffffffff),
                            alignment: Alignment.center,
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
