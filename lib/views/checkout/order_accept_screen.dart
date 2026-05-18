import 'package:flutter/material.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/screens/store/home_screen.dart';
import 'package:store_app/widgets/store_elevated_btn.dart';
import 'package:store_app/widgets/store_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderAccept extends StatefulWidget {
  const OrderAccept({super.key});

  @override
  State<OrderAccept> createState() => _OrderAcceptState();
}

class _OrderAcceptState extends State<OrderAccept> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15).r,
        child: Column(
          spacing: 15.h,
          crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SvgPicture.asset("${AppAsset.imageUrl}acceptOrder.svg"),
           Center(
             child: StoreText(value: "Your Order has been \n accepted", color: Color(0xff181725),
                 fontWeight: FontWeight.bold, fontSize: 22.sp,textAlign: TextAlign.center),
           ),
           Center(
             child: StoreText(value: "Your items has been placed and is on \n it's way to being processed ",
                 color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 14.sp),
           ),
           SizedBox(height: 60.h,),
           SizedBox(
           height:60.h ,
           width: 364.w,
           child: StoreElevatedBtn(value: "Track Order",
               color: AppColor.mainColor, borderRadius: BorderRadius.circular(19).r,
               onPressed: () {},),),
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
    );
  }
}
