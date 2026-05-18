import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/widgets/store_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List<Map<String,dynamic>> profileItems =[
    {
      "iconUrl":"${AppAsset.imageUrl}order.svg",
      "title": "Orders",
    },
    {
      "iconUrl":"${AppAsset.imageUrl}details.svg",
      "title": "My Details",
    },
    {
      "iconUrl":"${AppAsset.imageUrl}address.svg",
      "title": "Delivery Address",
    },
    {
      "iconUrl":"${AppAsset.imageUrl}payment.svg",
      "title": "Payment Methods",
    },
    {
      "iconUrl":"${AppAsset.imageUrl}promoCode.svg",
      "title": "Promo Code",
    },
    {
      "iconUrl":"${AppAsset.imageUrl}bell.svg",
      "title": "Notifications",
    },
    {
      "iconUrl":"${AppAsset.imageUrl}help.svg",
      "title": "Help",
    },
    {
      "iconUrl":"${AppAsset.imageUrl}about.svg",
      "title": "About",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
      ),
      backgroundColor: Color(0Xffffffff),
      body: Padding(
        padding:  EdgeInsets.all(15).r,
        child: SingleChildScrollView(
          child: Column(
            spacing: 15.h,
            children: [
              SizedBox(height:15.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 20.w,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100).r,
                    child: Image.asset("${AppAsset.imageUrl}myprofile.jpg",width: 70.w,
                      height: 100.h,fit: BoxFit.cover,),
                  ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 15.w,
                          children: [
                            StoreText(value: "Rawan Azzam", color: Color(0xff181725), fontWeight: FontWeight.w500, fontSize: 14.sp),
                            InkWell(onTap: () {}, child: SvgPicture.asset("${AppAsset.imageUrl}edit.svg"))
                          ],
                        ),
                        StoreText(value: "rawan@gmail.com", color: Color(0xff7C7C7C),
                            fontWeight: FontWeight.w300, fontSize: 13.sp),
                      ],
                    ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: profileItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                width: 0.5.w,
                                color: Color(0xffE2E2E2)
                            )
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15).r,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                spacing: 20.w,
                                children: [
                                  SvgPicture.asset("${profileItems[index]["iconUrl"]}",colorFilter: ColorFilter.mode(Color(0xff181725), BlendMode.srcIn),width: 30.w,height: 30.h,),
                                  StoreText(value: "${profileItems[index]["title"]}", color: Color(0xff181725),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.sp)
                                ],
                              ),
                              IconButton(onPressed: () {}, icon:
                              Icon(Icons.arrow_forward_ios_rounded,color:Color(0xff212121) ,size: 18.sp,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },),
              SizedBox(height: 10.h,),
              InkWell(
                onTap: () {

                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffF2F3F2),
                    borderRadius: BorderRadius.circular(19).r
                  ),
                  height: 90.h,
                  width:364.w ,
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: 15.w),
                        child: SvgPicture.asset("${AppAsset.imageUrl}logout.svg",
                          alignment: AlignmentGeometry.centerLeft,),
                      ),
                      Expanded(
                        child: Center(
                          child: StoreText(value: "Logout", color: AppColor.mainColor,
                              fontWeight: FontWeight.w500, fontSize: 20.sp,textAlign: TextAlign.center,),
                        ),
                      ),
                    ],
                  ),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
