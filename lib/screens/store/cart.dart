import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/widgets/store_elevated_btn.dart';
import 'package:store_app/widgets/store_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int counter = 0;
  List<Map<String, dynamic>> cartItems =[
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
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10).r,
                  height: 150.h,
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
                      Image.asset("${cartItems[index]["imageUrl"]}",width: 80.w,height: 80.h,
                        fit: BoxFit.contain,),
                      Column(
                        spacing: 20.h,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h,),
                              StoreText(value: "${cartItems[index]["title"]}", color: Color(0xff181725),
                                  fontWeight: FontWeight.w500, fontSize: 15.sp),
                              StoreText(value: "1Kg/Price", color: Color(0xff7C7C7C),
                                  fontWeight: FontWeight.w300, fontSize: 12.sp),
                            ],
                          ),
                          Row(
                            spacing: 15.w,
                            children: [
                              Container(
                                  width: 45.5.w,
                                  height: 45.5.h,
                                  decoration: BoxDecoration(
                                    border: BoxBorder.all(
                                      color: Color(0xff7C7C7C),
                                      width: 1.w
                                    ),
                                    borderRadius: BorderRadius.circular(10).r
                                  ),
                                  child: IconButton(onPressed: () {
                                    setState(() {
                                      if (cartItems[index]['quantity'] > 1) {
                                        setState(() {
                                          cartItems[index]['quantity']--;
                                        });
                                      }
                                    });
                                  }, icon: Icon(Icons.minimize, color: Color(0xff7C7C7C),)),
                              ) ,
                              Text("${cartItems[index]["quantity"]}",style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp
                              ),),
                              Container(
                                  width: 45.5.w,
                                  height: 45.5.h,
                                  decoration: BoxDecoration(
                                    border: BoxBorder.all(
                                      color: Color(0xff7C7C7C),
                                      width: 1.w
                                    ),
                                    borderRadius: BorderRadius.circular(10).r
                                  ),
                                  child: IconButton(onPressed: () {
                                    setState(() {
                                      cartItems[index]["quantity"]++;
                                    });
                                  }, icon: Icon(Icons.add, color: AppColor.mainColor,)),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(onPressed: () {}, icon:
                          Icon(Icons.close,color:Color(0xff7C7C7C) ,)),
                          SizedBox(height: 30.h,),
                          StoreText(value: "4.99\$", color: Color(0xff121212),
                              fontWeight: FontWeight.w500, fontSize: 16.sp)
                        ],
                      ),
                    ],
                  ),
                );
              },),
                SizedBox(height: 20.h,),
                SizedBox(
                  height: 70.h,
                  width: 364.w,
                  child: StoreElevatedBtn(value: "Go to Checkout", color: AppColor.mainColor,
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
