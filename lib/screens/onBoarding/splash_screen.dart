import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/screens/onBoarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          Onboarding(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      child: Scaffold(
        backgroundColor: AppColor.mainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child:Image.asset("${AppAsset.imageUrl}logo.png",
              fit: BoxFit.contain,height: 68.h,width: 250.w,),)
          ],
        ),
      ),
    );
  }
}
