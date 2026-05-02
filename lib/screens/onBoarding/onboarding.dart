import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/core/theme/app_color.dart';

import '../../widgets/store_elevated_btn.dart';
import '../../widgets/store_text.dart';
import '../Auth/signin.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: Size(414, 876),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/images/bg.png",fit: BoxFit.cover,
            width:double.infinity,),
            Positioned(
              bottom:100,
              right: 0,
              left: 0,
              child: Column(
                spacing: 12.h,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("${AppAsset.imageUrl}carrot_logo.svg",width: 38.w,
                    height:43.h,fit: BoxFit.cover,),
                  StoreText(color:AppColor.textColor ,fontWeight: FontWeight.w600,
                    fontSize:24 ,value: "Welcome to our store"),
                  StoreText(color: AppColor.textColor, fontWeight: FontWeight.w300,
                      fontSize: 12.sp,
                      value: "Ger your groceries in as fast as one hour"),
                  SizedBox(
                    width: 300.w,
                      height:45.h ,
                      child:
                  StoreElevatedBtn(value:'Get Started', color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(15).r, onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context) => Signin(),));
                    },)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



