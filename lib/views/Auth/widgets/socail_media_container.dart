import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_asset.dart';
import '../../../widgets/store_text.dart';

class SocialMediaContainer extends StatelessWidget {
  final Color containerColor ;
  final String value;
  final String imageSrc;
  const SocialMediaContainer({
    super.key, required this.containerColor, required this.value, required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width:360.w ,
      padding: EdgeInsets.all(15).r,
      margin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
      decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(25).r
      ),
      child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(imageSrc,width: 30,height: 30,),
          StoreText(value:value , color: Color(0xffFCFCFC), fontWeight: FontWeight.w500,
              fontSize: 16.5.sp,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}