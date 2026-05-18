import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/widgets/store_elevated_btn.dart';
import 'package:store_app/widgets/store_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: Size(4141, 896),
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Column(
          spacing: 15.h,
          children: [
            Container(
              width: 413.w,
              height: 371.h,
              decoration: BoxDecoration(
                color: Color(0xffF2F3F2),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(19).r,
                    bottomRight:Radius.circular(19).r )
              ),
              child: Image.asset("${AppAsset.imageUrl}product.png"),
            ),
            Padding(
              padding: EdgeInsets.all(20).r,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
              child: Column(
                spacing: 15.h,
              children: [
                  Row(
                    spacing: 15.w,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 15.w,
                        children: [
                          StoreText(value: "Natural Red Apple", color: Color(0xff181725),
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                          StoreText(value: "1Kg,Price", color: Color(0xff7C7C7C),
                              fontWeight: FontWeight.w400, fontSize: 15.sp),
                        ],),
                      SvgPicture.asset("${AppAsset.imageUrl}love.svg")
                    ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.minimize_rounded,
                              color: Color(0xffB3B3B3),fontWeight: FontWeight.bold,size:28.sp )),
                          Container(alignment: Alignment.center,
                            width:45.w ,
                            height: 45.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15).r,
                                border: BoxBorder.all(
                                    width: 1.w,
                                    color: Color(0xffE2E2E2)
                                )
                            ),child: Text("1",textAlign: TextAlign.center,style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold
                            ),),),
                          IconButton(onPressed: () {}, icon: Icon(Icons.add,
                            color: Color(0xff53B175),fontWeight: FontWeight.bold,size:28.sp ,))
                        ],
                      ),
                      StoreText(value: "15.5\$", color: Color(0xff181725), fontWeight: FontWeight.bold,
                          fontSize: 18.sp)
                    ],),
                Divider(height: 0.5,color:Color(0xffE2E2E2),),
                  Column(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => setState(() => isExpanded = !isExpanded),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StoreText(value: "Product Details", color: Color(0xff181725),
                                fontWeight: FontWeight.w600 ,fontSize: 18.sp),
                            AnimatedRotation(
                              duration: Duration(milliseconds: 300),
                              turns: isExpanded ? 0.5 : 0,
                              child:  Icon(Icons.keyboard_arrow_down_sharp, size: 28),
                            ),
                          ],),
                      ),
                      AnimatedCrossFade(firstChild: SizedBox(width: double.infinity),
                        secondChild: StoreText(value: "Apples are nutritious apples may be good for "
                            "weight loss apples may be goog for you heart. as part of a healthful "
                            " and varied diet.", color: Color(0xff7C7C7C),fontWeight: FontWeight.w400, fontSize: 14.sp),
                        crossFadeState:isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                        duration:  Duration(milliseconds: 300),)
                    ],
                  ),
                Divider(height: 0.5,color:Color(0xffE2E2E2),),
                Column(
                  spacing: 15.h,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                           StoreText(value: "Nutrition", color: Color(0xff181725),
                               fontWeight: FontWeight.w600 ,fontSize: 18.sp),

                         ],),
                          Row(
                            children: [
                              Container(width: 33.w,
                                height:16.h ,
                                decoration: BoxDecoration(color: Color(0xffEBEBEB),
                                    borderRadius: BorderRadius.circular(5).r
                                ),child: StoreText(value: "100gr",
                                    color: Color(0xff7C7C7C), fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                              ),
                              Icon(Icons.arrow_back_ios_rounded,size: 18.sp,),
                            ],
                          )
                    ],
                  ),
                  ]
              ),
                Divider(height: 0.5,color:Color(0xffE2E2E2),),
                Column(
                    spacing: 15.h,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                         StoreText(value: "Review", color: Color(0xff181725),
                             fontWeight: FontWeight.w600 ,fontSize: 18.sp),

                       ],),
                        Row(
                          children: [
                        SvgPicture.asset("${AppAsset.imageUrl}star.svg"),
                        SvgPicture.asset("${AppAsset.imageUrl}star.svg"),
                        SvgPicture.asset("${AppAsset.imageUrl}star.svg"),
                        SvgPicture.asset("${AppAsset.imageUrl}star.svg"),
                        SvgPicture.asset("${AppAsset.imageUrl}star.svg"),
                            Icon(Icons.arrow_back_ios_rounded,size: 18.sp,),
                          ],
                        )
                  ],
                ),
                ]
                              ),
                ],),
            ),
            ),
            SizedBox(
            height: 67.h,
            width: 398.w,
            child: StoreElevatedBtn( value: "Add to cart", color: AppColor.mainColor,
                borderRadius: BorderRadius.circular(19).r, onPressed: () {},),),
          ],
        ),
      ),
    );
  }
}
