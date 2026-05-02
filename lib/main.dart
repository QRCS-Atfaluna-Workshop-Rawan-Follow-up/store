import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/screens/onBoarding/onboarding.dart';
import 'package:store_app/screens/onBoarding/splash_screen.dart';
import 'package:store_app/screens/store/favoruite.dart';
import 'package:store_app/screens/store/home.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // builder: EasyLoading.init(),
      ),
    );
  }
}

