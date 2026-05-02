import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/core/theme/app_theme.dart';
import 'package:store_app/screens/store/cart.dart';
import 'package:store_app/screens/store/explore.dart';
import 'package:store_app/screens/store/widgets/main_sections_listview.dart';
import 'package:store_app/screens/store/widgets/search_text_feild.dart';
import 'package:store_app/screens/store/widgets/store_list_view.dart';
import 'package:store_app/widgets/store_text.dart';

import 'account.dart';
import 'favoruite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();
  bool isActive = false;
  // late int selectedItem = 0;
  int index = 0;
  int count = 0;
  late final TextEditingController searchController;
  List<Map<String, String>> exclusiveContent = [
    {
      "imageUrl": "${AppAsset.imageUrl}banan.png",
      "title": "Organic Banan",
      "subtitle": "1kg,Price",
      "price": "4.99",
    },
    {
      "imageUrl": "${AppAsset.imageUrl}apple.png",
      "title": "Red Apple",
      "subtitle": "1kg,Price",
      "price": "5.99",
    },
    {
      "imageUrl": "${AppAsset.imageUrl}banan.png",
      "title": "Organic Banan",
      "subtitle": "1kg,Price",
      "price": "4.99",
    },
  ];
  List<Map<String, String>> bestSellingContent = [
    {
      "imageUrl": "${AppAsset.imageUrl}chili-peper.png",
      "title": "Bell Papper Red",
      "subtitle": "1kg,Price",
      "price": "4.99",
    },
    {
      "imageUrl": "${AppAsset.imageUrl}ginger.png",
      "title": "Ginger",
      "subtitle": "1kg,Price",
      "price": "5.99",
    },
    {
      "imageUrl": "${AppAsset.imageUrl}banan.png",
      "title": "Organic Banan",
      "subtitle": "1kg,Price",
      "price": "4.99",
    },
  ];
  List<Map<String, String>> groceriesContent = [
    {
      "imageUrl": "${AppAsset.imageUrl}meat.png",
      "title": "Beaf Bone",
      "subtitle": "1kg,Price",
      "price": "4.99",
    },
    {
      "imageUrl": "${AppAsset.imageUrl}chiken.png",
      "title": "Broiler Chicken",
      "subtitle": "1kg,Price",
      "price": "5.99",
    },
    {
      "imageUrl": "${AppAsset.imageUrl}banan.png",
      "title": "Organic Banan",
      "subtitle": "1kg,Price",
      "price": "4.99",
    },
  ];
  List<Map<String, dynamic>> mainSections = [
  {
  "imageUrl": "${AppAsset.imageUrl}pules.png",
  "title": "Pules",
  "backgroundColor":Color(0xfffef1e4)
},  {
  "imageUrl": "${AppAsset.imageUrl}rice.png",
  "title": "Rice",
  "backgroundColor":Color(0xffe5f3ea)
},
    ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 1553),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffffffff),
        body: index == 0
            ? SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15).r,
                  child: Column(
                    spacing: 15.h,
                    children: [
                      SizedBox(height: 50.h),
                      Column(
                        spacing: 10.h,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "${AppAsset.imageUrl}colorful-carrot.svg",
                            width: 30.w,
                            height: 30.h,
                          ),
                          Row(
                            spacing: 15.w,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "${AppAsset.imageUrl}location-icon.svg",
                              ),
                              StoreText(
                                value: "Palestine,Gaza",
                                color: Color(0xff4C4F4D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ],
                          ),
                          Form(
                            key: formKey,
                            child: SizedBox(
                              height: 51.h,
                              width: 364.w,
                              child: SearchTextFeild(
                                searchController: searchController,
                                onSearchPressed: () {
                                  if (formKey.currentState!.validate()) {}
                                },
                                onFieldSubmitted: (value) {
                                  if (formKey.currentState!.validate()) {}
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Entre the true value';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Image.asset("${AppAsset.imageUrl}banner.png"),
                            ],
                          ),
                          Row(
                            spacing: 10.w,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StoreText(
                                value: "Exclusive Offer",
                                color: Color(0xff181725),
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                              StoreText(
                                value: "See more",
                                color: AppColor.mainColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 220.h,
                            child: StoreListView(content: exclusiveContent),
                          ),
                          Row(
                            spacing: 10.w,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StoreText(
                                value: "Best Selling",
                                color: Color(0xff181725),
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                              StoreText(
                                value: "See all",
                                color: AppColor.mainColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 220.h,
                            child: StoreListView(content: bestSellingContent),
                          ),
                          Row(
                            spacing: 10.w,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StoreText(
                                value: "Groceries",
                                color: Color(0xff181725),
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                              StoreText(
                                value: "See all",
                                color: AppColor.mainColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ],
                          ),
                            SizedBox(
                              height: 115.h,
                              width: 320.w,
                              child: MainSectionListView(mainSections: mainSections),
                            ),
                          SizedBox(
                            height: 220.h,
                            child: StoreListView(content: groceriesContent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : index ==1 ? Explore(): index == 2 ? Cart(): index==3 ? Favoruite():
        index==4 ? Account(): null,
        bottomNavigationBar: Container(
          height: 90.h,
          width: 414.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15).r,
              topLeft: Radius.circular(15).r,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15).r,
              topLeft: Radius.circular(15).r,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xffffffff),
              unselectedItemColor: Color(0xff121212),
              selectedItemColor: AppColor.mainColor,
              currentIndex: index,
              onTap: (value) {
                setState(() {
                  index = value;
                  print(index);
                });
              },
              selectedLabelStyle: TextStyle(
                color: AppTheme.navigationActiveColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              elevation: 0.5,
              unselectedLabelStyle: TextStyle(
                color: Color(0xff121212),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "${AppAsset.imageUrl}store.svg",
                    color: index == 0 ? AppColor.mainColor : AppColor.titleColor,
                  ),
                  label: "Shop",
                  backgroundColor: Color(0xffffffff),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "${AppAsset.imageUrl}explore.svg",
                    color: index == 1 ? AppColor.mainColor : AppColor.titleColor,
                  ),
                  label: "Explore",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "${AppAsset.imageUrl}cart.svg",
                    color: index == 2 ? AppColor.mainColor : AppColor.titleColor,
                  ),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "${AppAsset.imageUrl}favourit.svg",
                    color: index == 3 ? AppColor.mainColor : AppColor.titleColor,
                  ),
                  label: "Favourite",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "${AppAsset.imageUrl}user.svg",
                    color: index == 4 ? AppColor.mainColor : AppColor.titleColor,
                  ),
                  label: 'Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


