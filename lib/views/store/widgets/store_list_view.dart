import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/routes/app_routes.dart';
import 'package:store_app/views/store/widgets/shimmer_loading.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/category_controller.dart';
import '../../../core/theme/app_color.dart';
import 'package:get/get.dart';
import '../../widgets/store_text.dart';

class StoreListView extends StatelessWidget {
  const StoreListView({
    super.key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    this.itemCount,
    this.products,
  });

  final Axis scrollDirection;
  final bool reverse;
  final int? itemCount;
  final List<dynamic>? products;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        if (controller.isLoading) {
          return SizedBox(
            height: 290.h,
            child: ListView.builder(
              scrollDirection: scrollDirection,
              itemCount: itemCount ?? 4,
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
          return  Center(child: Text("No categories found"));
        }

        var productList = products ?? controller.categoryModel!.data!;
        int finalCount = itemCount ?? productList.length;
        if (finalCount > productList.length) {
          finalCount = productList.length;
        }

        return SizedBox(
          height: 500.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: scrollDirection,
            itemCount: finalCount,
            reverse: reverse,
            padding: EdgeInsets.all(5.r),
            itemBuilder: (context, index) {
              var product = productList[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.productDetails, arguments: product);
                },
                child: Container(
                  padding: EdgeInsets.all(10).r,
                  margin: EdgeInsets.all(8).r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25).r,
                    border: Border.all(color: const Color(0xffE2E2E2)),
                  ),
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
                          color:  Color(0xff181725),
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                        StoreText(
                          value: "${product?.unit}",
                          color:  Color(0xff7C7C7C),
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
                              color: const Color(0xff181725),
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
                                  Get.find<CartController>().addToCart(product?.id);
                                },
                                icon: const Icon(
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
                ),
              );
            },
          ),
        );
      },
    );
  }
}