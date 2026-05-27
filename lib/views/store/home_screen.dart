import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/controllers/category_controller.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/core/theme/app_theme.dart';
import 'package:store_app/views/store/cart_screen.dart';
import 'package:store_app/views/store/explore_screen.dart';
import 'package:store_app/views/store/widgets/cart_icon_budge.dart';
import 'package:store_app/views/store/widgets/main_sections_listview.dart';
import 'package:store_app/views/store/widgets/search_text_feild.dart';
import 'package:store_app/views/store/widgets/store_list_view.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../core/localization/storaged_services.dart';
import '../sidebarItems/custom_drower_widget.dart';
import '../widgets/store_text.dart';
import 'account_screen.dart';
import 'favourite_screen.dart';
// 💡 استيراد ملف السايد بار الجديد

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();
  bool isActive = false;
  int index = 0;
  int count = 0;
  late final TextEditingController searchController;
  final storage = Get.find<StorageService>();
  final homeController = Get.put(HomeController());
  final categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
      "backgroundColor": const Color(0xfffef1e4)
    },
    {
      "imageUrl": "${AppAsset.imageUrl}rice.png",
      "title": "Rice",
      "backgroundColor": const Color(0xffe5f3ea)
    },
  ];

  @override
  Widget build(BuildContext context) {
    // String country = storage.read('zone') ?? "Select Zone";
    // String city = storage.read('area') ?? "Location";

    return ScreenUtilInit(
      designSize:  Size(414, 1553),
      child: Scaffold(
        drawer:  CustomDrawer(),
        appBar: AppBar(
          backgroundColor:  Color(0xffffffff),
          elevation: 0,
          leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                      Icons.menu_rounded,
                      color:  Color(0xff181725),
                      size: 34.r
                  ),
                );
              }
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10).r,
              child: CartBadgeIcon(),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor:  Color(0xffffffff),
        body: index == 0
            ? SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(15).r,
            child: Column(
              spacing: 15.h,
              children: [
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
                        GetBuilder<HomeController>(
                          builder: (controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "${AppAsset.imageUrl}location-icon.svg",
                                ),
                                SizedBox(width: 15.w),
                                StoreText(
                                  value: "${controller.country}, ${controller.city}",
                                  color: const Color(0xff4C4F4D),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: SizedBox(
                        height: 67.h,
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
                              return 'Please Enter the true value';
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
                          color: const Color(0xff181725),
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                        const StoreText(
                          value: "See more",
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ],
                    ),
                    StoreListView(
                      products: categoryController.firstSectionProducts,),
                    Row(
                      spacing: 10.w,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StoreText(
                          value: "Best Selling",
                          color:  Color(0xff181725),
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                        StoreText(
                          value: "See all",
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                    StoreListView(products: categoryController.secondSectionProducts, ),
                    Row(
                      spacing: 10.w,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StoreText(
                          value: "Groceries",
                          color:  Color(0xff181725),
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
                      height: 120.h,
                      child: MainSectionListView(mainSections: mainSections),
                    ),
                    StoreListView(products: categoryController.thirdSectionProducts,),
                  ],
                ),
              ],
            ),
          ),
        )
            : index == 1
            ? const Explore()
            : index == 2
            ? const Cart()
            : index == 3
            ?  Favoruite()
            : index == 4
            ? const Account()
            : const SizedBox.shrink(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight:  Radius.circular(15).r,
              topLeft:  Radius.circular(15).r,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(15).r,
              topLeft: const Radius.circular(15).r,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xffffffff),
              unselectedItemColor: const Color(0xff121212),
              selectedItemColor: AppColor.mainColor,
              currentIndex: index,
              onTap: (value) {
                setState(() {
                  index = value;
                });
              },
              selectedLabelStyle: TextStyle(
                color: AppTheme.navigationActiveColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              elevation: 0.5,
              unselectedLabelStyle: TextStyle(
                color: const Color(0xff121212),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "${AppAsset.imageUrl}store.svg",
                    colorFilter: ColorFilter.mode(
                      index == 0 ? AppColor.mainColor : AppColor.titleColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "Shop",
                  backgroundColor: const Color(0xffffffff),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "${AppAsset.imageUrl}explore.svg",
                    colorFilter: ColorFilter.mode(
                      index == 1 ? AppColor.mainColor : AppColor.titleColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "Explore",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "${AppAsset.imageUrl}cart.svg",
                    colorFilter: ColorFilter.mode(
                      index == 2 ? AppColor.mainColor : AppColor.titleColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "${AppAsset.imageUrl}favourit.svg",
                    colorFilter: ColorFilter.mode(
                      index == 3 ? AppColor.mainColor : AppColor.titleColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: "Favourite",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "${AppAsset.imageUrl}user.svg",
                    colorFilter: ColorFilter.mode(
                      index == 4 ? AppColor.mainColor : AppColor.titleColor,
                      BlendMode.srcIn,
                    ),
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