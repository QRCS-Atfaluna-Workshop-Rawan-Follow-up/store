import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/controllers/checkout_contoller.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../checkout/checkout_bottom_sheet.dart';
import '../widgets/store_elevated_btn.dart';
import '../widgets/store_text.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CheckoutController checkoutController = Get.put(CheckoutController());

  @override
  void initState() {
    super.initState();
    Get.find<CartController>().fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xffffffff),
          title: StoreText(
            value: "My Cart",
            color: const Color(0xff181725),
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        body: GetBuilder<CartController>(
          builder: (controller) {
            if (controller.cartItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined, size: 80.sp, color: Colors.grey),
                    StoreText(value: "Cart is Empty", color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20.sp)
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
                      physics: const ScrollPhysics(),
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = controller.cartItems[index];

                        // 1. حساب السعر الرقمي الإجمالي للمنتج الحالي (السعر * الكمية)
                        final double unitPrice = double.tryParse(item.product?.unitPrice.toString() ?? '0') ?? 0.0;
                        final int quantity = item.quantity ?? 1;
                        final double totalPriceForItem = unitPrice * quantity;

                        // 2. تحويل الرقم لنص وقص الأصفار الزائدة بالـ RegExp
                        String priceToShow = totalPriceForItem.toStringAsFixed(2).replaceAll(RegExp(r'\.00$|(?<=\.\d)0$'), '');

                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10).r,
                          height: 150.h,
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                width: 1,
                                color: Color(0xffE2E2E2),
                              ),
                            ),
                          ),
                          child: Row(
                            spacing: 15.h,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                item.thumbnail ?? '',
                                width: 80.w,
                                height: 80.h,
                                fit: BoxFit.contain,
                              ),
                              Column(
                                spacing: 20.h,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.h),
                                      StoreText(
                                        value: item.product?.name ?? '',
                                        color: const Color(0xff181725),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                      ),
                                      StoreText(
                                        value: "${item.product?.unit}",
                                        color: const Color(0xff7C7C7C),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12.sp,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    spacing: 15.w,
                                    children: [
                                      Container(
                                        width: 45.5.w,
                                        height: 45.5.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xffE2E2E2),
                                            width: 1.w,
                                          ),
                                          borderRadius: BorderRadius.circular(17).r,
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            controller.decrementQuantity(item);
                                          },
                                          icon: const Icon(Icons.remove, color: Color(0xffB3B3B3)),
                                        ),
                                      ),
                                      Text(
                                        "$quantity",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Container(
                                        width: 45.5.w,
                                        height: 45.5.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xffE2E2E2),
                                            width: 1.w,
                                          ),
                                          borderRadius: BorderRadius.circular(17).r,
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            controller.incrementQuantity(item);
                                          },
                                          icon: Icon(Icons.add, color: AppColor.mainColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      controller.deleteFromCart(item.id);
                                    },
                                    icon: const Icon(Icons.close, color: Color(0xff7C7C7C)),
                                  ),
                                  SizedBox(height: 30.h),

                                  // عرض القيمة النظيفة الخالية من الأصفار المزعجة هنا
                                  StoreText(
                                    value: "\$$priceToShow",
                                    color: const Color(0xff121212),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    // 🟢 الجزء الجديد: عرض السعر الإجمالي الكلي من السيرفر (Total Price)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StoreText(
                            value: "Total Price",
                            color: const Color(0xff181725),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                          Builder(
                            builder: (context) {
                              // قراءة الـ finalTotalCost وتحويله برمجياً لـ double احتياطاً لتنظيف الأصفار
                              final double finalCost = double.tryParse(controller.finalTotalCost.toString()) ?? 0.0;
                              String formattedTotal = finalCost.toStringAsFixed(2).replaceAll(RegExp(r'\.00$|(?<=\.\d)0$'), '');

                              return StoreText(
                                value: "\$$formattedTotal",
                                color: const Color(0xff181725),
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // زر الانتقال إلى شاشة الدفع والـ Bottom Sheet
                    SizedBox(
                      height: 67.h,
                      width: 364.w,
                      child: StoreElevatedBtn(
                        value: "Go to Checkout".tr,
                        color: AppColor.mainColor,
                        borderRadius: BorderRadius.circular(19).r,
                        onPressed: () {
                          Get.bottomSheet(
                            const CheckoutBottomSheet(),
                            isScrollControlled: true,
                            ignoreSafeArea: false,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h), // مسافة أمان إضافية بالأسفل
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