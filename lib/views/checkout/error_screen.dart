import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/widgets/store_elevated_btn.dart';
import 'package:store_app/widgets/store_text.dart';

import '../store/home_screen.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(364, 601),
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 15.h,
              children: [
                Image.asset("${AppAsset.imageUrl}errors.png"),
                StoreText(value: "Oops! Order Failed",
                    color: Color(0xff212121), fontWeight: FontWeight.bold, fontSize: 18.sp),
                StoreText(value: "Something went tembly wrong",
                    color: Color(0xff7C7C7C),
                    fontWeight: FontWeight.w400, fontSize: 16.sp),
                SizedBox(height: 25.h),
                SizedBox(height: 67.h,
                width:364.w ,
                child: StoreElevatedBtn(value: "Please Try again", color:
                AppColor.mainColor, borderRadius: BorderRadius.circular(19).r, onPressed: () {},),),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
                  } ,
                  child: StoreText(value: "Back to Home", color: Color(0xff181725),
                      fontWeight: FontWeight.w500, fontSize: 18.sp),
                )
              ],
            ),
          ),
      ),
    );
  }
}
