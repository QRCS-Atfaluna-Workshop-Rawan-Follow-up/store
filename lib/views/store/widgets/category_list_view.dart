import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_color.dart';
import '../../widgets/store_text.dart';

class ListviewCategory extends StatelessWidget {
  const ListviewCategory({
    super.key,
    required this.content,
     this.childAspectRatio = 0.5/0.8,
     this.crossAxisSpacing = 10,
     this.mainAxisSpacing = 20,
  });

  final List<Map<String, String>> content;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: content.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20.h,vertical: 0.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: mainAxisSpacing.h  ,
            crossAxisSpacing: crossAxisSpacing.w ,
            childAspectRatio: childAspectRatio ,

        ),
        itemBuilder: (context, index) {
          return Container(
            // width:173.5.w ,
            // height: 268.h,
            padding: EdgeInsets.all(5).r,
            margin: EdgeInsets.all(5).r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25).r,
                border: BoxBorder.all(
                    color: Color(0xffE2E2E2)
                )
            ),
            child: Padding(
              padding:  EdgeInsets.all(10).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5.h,
                children: [
                  Center(
                    child: Image.asset("${content[index]['imageUrl']}",
                      width: 60.w,height: 60.h,),
                  ),
                  StoreText(value: "${content[index]['title']}", color: Color(0xff181725),
                      fontWeight: FontWeight.w500, fontSize: 14.sp),
                  StoreText(value: "${content[index]['subtitle']}", color: Color(0xff7C7C7C),
                      fontWeight: FontWeight.w500, fontSize: 12.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StoreText(value: '${content[index]['price']}\$', color: Color(0xff181725), fontWeight: FontWeight.w500, fontSize: 16.sp),
                      Container(
                        width: 44.5.w,
                        height: 44.5.h,
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(19).r
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
        }
    );
  }
}