import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/widgets/store_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_asset.dart';
import '../../core/theme/app_color.dart';
import '../../widgets/store_elevated_btn.dart';

class Favoruite extends StatefulWidget {
  Favoruite({super.key});

  @override
  State<Favoruite> createState() => _FavoruiteState();
}

class _FavoruiteState extends State<Favoruite> {
  List<Map<String, dynamic>> favouriteItems =[
    {
      "imageUrl":"${AppAsset.imageUrl}chili-peper.png",
      "title":"Bell Paper Red",
      "quantity" :1
    },
    {
      "imageUrl":"${AppAsset.imageUrl}banan.png",
      "title":"Banana",
      "quantity" :5
    },
    {
      "imageUrl":"${AppAsset.imageUrl}ginger.png",
      "title":"Egg",
      "quantity" :10
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffffffff),
          title: StoreText(value: "My Cart", color: Color(0xff181725), fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
        body: Padding(
          padding:  EdgeInsets.all(20).r,
          child: SingleChildScrollView(
            child: Column(
              spacing: 15.h,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: favouriteItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10).r,
                      height: 120.h,
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  width: 1.w,
                                  color: Color(0xffE2E2E2)
                              )
                          )
                      ),
                      child: Row(
                        spacing: 15.h,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("${favouriteItems[index]["imageUrl"]}",width: 70.w,height: 70.h,
                            fit: BoxFit.contain,),
                          Column(
                            spacing: 20.h,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h,),
                                  StoreText(value: "${favouriteItems[index]["title"]}", color: Color(0xff181725),
                                      fontWeight: FontWeight.w500, fontSize: 15.sp),
                                  StoreText(value: "1Kg/Price", color: Color(0xff7C7C7C),
                                      fontWeight: FontWeight.w300, fontSize: 12.sp),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            // spacing: 10.h,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  StoreText(value: "4.99\$", color: Color(0xff121212),
                                      fontWeight: FontWeight.w500, fontSize: 14.sp),
                                  IconButton(onPressed: () {}, icon:
                                  Icon(Icons.arrow_forward_ios_rounded,color:Color(0xff212121) ,size: 18.sp,)),

                                ],
                              ),
                              SizedBox(height: 30.h,),

                            ],
                          ),
                        ],
                      ),
                    );
                  },),
                SizedBox(height: 20.h,),
                SizedBox(
                  height: 100.h,
                  width: 364.w,
                  child: StoreElevatedBtn(value: "Add All to cart", color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(19).r, onPressed: () {

                    },),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
