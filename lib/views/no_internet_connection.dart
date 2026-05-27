import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/views/widgets/store_text.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor:  Color(0xffFFFFFF),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color:  Color(0xffF2F3F2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.wifi_off_rounded,
                    size: 80.sp,
                    color:  Color(0xff7C7C7C),
                  ),
                ),
                SizedBox(height: 35.h),
                StoreText(
                  value: "No Connection",
                  color:  Color(0xff181725),
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
                SizedBox(height: 12.h),

                Text(
                  "Your internet connection is completely down. Please check your network settings and we will reconnect you automatically.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:  Color(0xff7C7C7C),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 45.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.r,
                      width: 20.r,
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                        strokeWidth: 2.5.w,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    StoreText(
                      value: "Waiting for network...",
                      color: AppColor.mainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}