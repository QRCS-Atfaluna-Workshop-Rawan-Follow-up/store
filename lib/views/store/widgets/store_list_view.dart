import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/routes/app_routes.dart';
import 'package:store_app/views/store/widgets/shimmer_loading.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/category-controller.dart';
import '../../../core/theme/app_color.dart';
import 'package:get/get.dart';
import '../../widgets/store_text.dart';

class StoreListView extends StatelessWidget {
  StoreListView({
    super.key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
  });

  // final List<Map<String, dynamic>> content;
  final Axis scrollDirection;
  // final String listId;
  final bool reverse;
  // CartController cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        if (controller.isLoading) {
          return SizedBox(
            height: 290.h, // ارتفاع مناسب متناسق مع كارت المنتج
            child: ListView.builder(
              scrollDirection: scrollDirection,
              itemCount: 4, // عرض 4 كروت رمادية وهمية متحركة أثناء الانتظار
              padding: EdgeInsets.all(5.r),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child:  ProductCardSkeleton(),
                );
              },
            ),
          );
        }

        if (controller.categoryModel!.data!.isEmpty) {
          return Center(child: Text("No categories found"));
        }
        var productList = controller.categoryModel!.data!;
        return SizedBox(
          height: 500.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: scrollDirection,
            itemCount: productList.length,
            reverse: reverse,
            padding: EdgeInsetsGeometry.all(5.r),
            itemBuilder: (context, index) {
              var product = controller.categoryModel?.data![index];
              // final product = Product(
              //   id: "${listId}_${content[index]['id'] ?? index}",
              //   name: content[index]['title'] ?? '',
              //   price: double.parse(content[index]['price'] ?? '0'),
              //   image: content[index]['imageUrl'] ?? '',
              // );
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.productDetails, arguments: product);
                },
                child: GetBuilder<CategoryController>(
                  init: CategoryController(),
                  builder: (controller) {
                    return Container(
                      // width:175.w ,
                      padding: EdgeInsets.all(10).r,
                      margin: EdgeInsets.all(8).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25).r,
                        border: BoxBorder.all(color: Color(0xffE2E2E2)),
                      ),
                      // height: 1060.h,
                      child: Padding(
                        padding: EdgeInsets.all(10).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10.h,
                          children: [
                            Center(
                              child: Image.network(
                                "${product?.thumbnail}",
                                width: 160.w,
                                height: 160.h,
                              ),
                            ),
                            StoreText(
                              value: "${product?.name}",
                              color: Color(0xff181725),
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                            StoreText(
                              value: "${product?.unit}",
                              color: Color(0xff7C7C7C),
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 50.w,
                              children: [
                                StoreText(
                                  value: '${product?.finalUnitPrice}\$',
                                  color: Color(0xff181725),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                                Container(
                                  width: 50.w,
                                  height: 90.h,
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color: AppColor.mainColor,
                                    borderRadius: BorderRadius.circular(25).r,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      // cartController.addToCart(product);
                                      Get.find<CartController>().addToCart(
                                        product?.id,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
