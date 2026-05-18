import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_color.dart';
import '../../../widgets/store_text.dart';

class StoreListView extends StatelessWidget {
  const StoreListView({
    super.key,
    required this.content,
    this.scrollDirection =Axis.horizontal,
  });

  final List<Map<String, String>> content;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: scrollDirection,
        itemCount:content.length ,
        padding: EdgeInsetsGeometry.all(5.r),
        itemBuilder: (context, index) {
          return Container(
            // width:175.w ,
            padding: EdgeInsets.all(10).r,
            margin: EdgeInsets.all(8).r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25).r,
                border: BoxBorder.all(
                    color: Color(0xffE2E2E2)
                )
            ),
            // height: 1060.h,
            child: Padding(
              padding:  EdgeInsets.all(10).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10.h,
                children: [
                  Center(child: Image.asset("${content[index]['imageUrl']}",
                    width: 160.w,height: 160.h,)),
                  StoreText(value: "${content[index]['title']}", color: Color(0xff181725),
                      fontWeight: FontWeight.w500, fontSize: 18.sp),
                  StoreText(value: "${content[index]['subtitle']}", color: Color(0xff7C7C7C),
                      fontWeight: FontWeight.w500, fontSize: 14.sp),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 50.w,
                    children: [
                      StoreText(value: '${content[index]['price']}\$', color: Color(0xff181725), fontWeight: FontWeight.w500, fontSize: 16.sp),
                      Container(
                        width: 50.w,
                        height: 90.h,
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(25).r,
                        ),
                        child: IconButton(onPressed: () {
                        }, icon: Icon(Icons.add,color: Color(0xffffffff),)),
                      )
                    ],
                  )
                ],

              ),
            ),
          );
        },),
    );
  }
}