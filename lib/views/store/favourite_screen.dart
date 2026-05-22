import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/controllers/cart_controller.dart';
import '../../controllers/whishlist_controller.dart';
import '../../core/theme/app_color.dart';
import '../widgets/store_elevated_btn.dart';
import 'package:get/get.dart';
import '../widgets/store_text.dart';

class Favoruite extends StatefulWidget {
  Favoruite({super.key});

  @override
  State<Favoruite> createState() => _FavoruiteState();
}

class _FavoruiteState extends State<Favoruite> {
  final favouriteController = Get.find<FavoriteController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouriteController.fetchFavorites();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffffffff),
          title: StoreText(
            value: "My Favourite Products",
            color: Color(0xff181725),
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        body: GetBuilder<FavoriteController>(
          builder: (controller) {
            if (controller.favoriteItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80.sp,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Your wishlist is empty",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Start adding your favorite items now!",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.all(20).r,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 15.h,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.favoriteItems.length,
                      itemBuilder: (context, index) {
                        final item = controller.favoriteItems[index];
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10).r,
                          height: 120.h,
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                width: 1.w,
                                color: Color(0xffE2E2E2),
                              ),
                            ),
                          ),
                          child: Row(
                            spacing: 15.h,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                "${item.thumbnail}",
                                width: 70.w,
                                height: 70.h,
                                fit: BoxFit.contain,
                              ),
                              Column(
                                spacing: 20.h,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.h),
                                      StoreText(
                                        value: "${item.name}",
                                        color: Color(0xff181725),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                      ),
                                      StoreText(
                                        value: "${item.unit}",
                                        color: Color(0xff7C7C7C),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12.sp,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                // spacing: 10.h,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StoreText(
                                        value: "${item.purchasePrice} \$",
                                        color: Color(0xff121212),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            controller.removeFromFavorites(item.id);
                                            print(item.id);
                                          },
                                        icon: Icon(
                                          Icons.close,
                                          color: Color(0xff212121),
                                          size: 20.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.h),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 67.h,
                      width: 364.w,
                      child: StoreElevatedBtn(
                        value: "Add All to cart",
                        color: AppColor.mainColor,
                        borderRadius: BorderRadius.circular(19).r,
                        onPressed: () {
                          favouriteController.addAllWishlistToCart(favouriteController.favoriteItems);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
