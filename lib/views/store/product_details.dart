// import 'package:flutter/material.dart';
// import 'package:store_app/controllers/cart_controller.dart';
// import 'package:store_app/core/theme/app_asset.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:store_app/core/theme/app_color.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get.dart';
// import '../../controllers/category-controller.dart';
// import '../../controllers/whishlist_controller.dart';
// import '../widgets/store_elevated_btn.dart';
// import '../widgets/store_text.dart';
//
// class ProductDetails extends StatefulWidget {
//   const ProductDetails({super.key});
//
//   @override
//   State<ProductDetails> createState() => _ProductDetailsState();
// }
//
// class _ProductDetailsState extends State<ProductDetails> {
//   bool isExpanded = false;
//
//   // تأمين استقبال الـ arguments والـ casting
//   final ProductData product = Get.arguments as ProductData;
//   late final id = product.id;
//
//   final categoryController = Get.find<CategoryController>();
//
//   @override
//   void initState() {
//     super.initState();
//     print("Product isFavorite: ${product.isFavorite}");
//     print("Product ID: ${product.id}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isFav = product.isFavorite ?? false;
//
//     // سحب أول صورة متوفرة وتنظيف الرابط الخاص بها
//     String cleanImgUrl = categoryController.getCleanImageUrl(
//       (product.images != null && product.images!.isNotEmpty)
//           ? product.images![0]
//           : product.thumbnail,
//     );
//
//     return ScreenUtilInit(
//       designSize: const Size(414, 896),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xffffffff),
//           elevation: 0,
//           leading: InkWell(
//             onTap: Get.back,
//             child: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           ),
//         ),
//         backgroundColor: const Color(0xffffffff),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               // حاوية الصورة الرئيسية مع حماية ضد الروابط المكسورة
//               Container(
//                 width: 414.w,
//                 height: 300.h,
//                 decoration: BoxDecoration(
//                   color: const Color(0xffF2F3F2),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(19).r,
//                     bottomRight: Radius.circular(19).r,
//                   ),
//                 ),
//                 child: cleanImgUrl.isNotEmpty
//                     ? Image.network(
//                   cleanImgUrl,
//                   width: 200.w,
//                   fit: BoxFit.cover,
//                   height: 350.h,
//                   errorBuilder: (context, error, stackTrace) =>
//                   const Icon(Icons.image_not_supported, size: 50),
//                 )
//                     : const Icon(Icons.image, size: 50),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20).r,
//                 child: Column(
//                   children: [
//                     // سكشن الاسم والوحدة والمفضلة
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded( // لحماية التصميم من الأسماء الطويلة جداً
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               StoreText(
//                                 value: "${product.name}",
//                                 color: const Color(0xff181725),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 22.sp,
//                               ),
//                               SizedBox(height: 5.h),
//                               StoreText(
//                                 value: '${product.unit}',
//                                 color: const Color(0xff7C7C7C),
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 15.sp,
//                               ),
//                             ],
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Get.find<FavoriteController>().addToFavorites(product.id!);
//                           },
//                           child: SvgPicture.asset(
//                             "${AppAsset.imageUrl}love.svg",
//                             // تغيير لون القلب بناءً على حالة المفضلة
//                             colorFilter: ColorFilter.mode(
//                               isFav ? Colors.red : const Color(0xff7C7C7C),
//                               BlendMode.srcIn,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             IconButton(
//                               onPressed: () {},
//                               icon: Icon(Icons.remove, color: const Color(0xffB3B3B3), size: 28.sp),
//                             ),
//                             Container(
//                               alignment: Alignment.center,
//                               width: 45.w,
//                               height: 45.h,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15).r,
//                                 border: Border.all(width: 1.w, color: const Color(0xffE2E2E2)), // تعديل BoxBorder
//                               ),
//                               child: Text(
//                                 "1",
//                                 style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {},
//                               icon: Icon(Icons.add, color: const Color(0xff53B175), size: 28.sp),
//                             ),
//                           ],
//                         ),
//                         StoreText(
//                           value: "${product.finalUnitPrice}\$",
//                           color: const Color(0xff181725),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.sp,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.h),
//                     const Divider(height: 1, color: Color(0xffE2E2E2)),
//                     SizedBox(height: 15.h),
//
//                     // سكشن تفاصيل المنتج القابل للتمدد (AnimatedCrossFade)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         InkWell(
//                           splashColor: Colors.transparent,
//                           highlightColor: Colors.transparent,
//                           onTap: () => setState(() => isExpanded = !isExpanded),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               StoreText(
//                                 value: "Product Details",
//                                 color: const Color(0xff181725),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 18.sp,
//                               ),
//                               AnimatedRotation(
//                                 duration: const Duration(milliseconds: 300),
//                                 turns: isExpanded ? 0.5 : 0,
//                                 child: const Icon(Icons.keyboard_arrow_down_sharp, size: 28),
//                               ),
//                             ],
//                           ),
//                         ),
//                         AnimatedCrossFade(
//                           firstChild: const SizedBox(width: double.infinity),
//                           secondChild: Padding(
//                             padding: EdgeInsets.symmetric(vertical: 10.h),
//                             child: StoreText(
//                               value: categoryController.getCleanDetails(product.details),
//                               color: const Color(0xff7C7C7C),
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                           crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//                           duration: const Duration(milliseconds: 300),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15.h),
//                     const Divider(height: 1, color: Color(0xffE2E2E2)),
//                     SizedBox(height: 15.h),
//
//                     // سكشن القيمة الغذائية (Nutrition)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         StoreText(
//                           value: "Nutrition",
//                           color: const Color(0xff181725),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18.sp,
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xffEBEBEB),
//                                 borderRadius: BorderRadius.circular(5).r,
//                               ),
//                               child: StoreText(
//                                 value: "100gr",
//                                 color: const Color(0xff7C7C7C),
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 12.sp,
//                               ),
//                             ),
//                             SizedBox(width: 5.w),
//                             Icon(Icons.arrow_forward_ios_rounded, size: 16.sp, color: Colors.black), // تعديل الاتجاه والأيقونة
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15.h),
//                     const Divider(height: 1, color: Color(0xffE2E2E2)),
//                     SizedBox(height: 15.h),
//
//                     // سكشن التقييمات (Review)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         StoreText(
//                           value: "Review",
//                           color: const Color(0xff181725),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18.sp,
//                         ),
//                         Row(
//                           children: [
//                             ...List.generate(5, (index) => Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 1.w),
//                               child: SvgPicture.asset("${AppAsset.imageUrl}star.svg", width: 15.w),
//                             )),
//                             SizedBox(width: 5.w),
//                             Icon(Icons.arrow_forward_ios_rounded, size: 16.sp, color: Colors.black), // تعديل الاتجاه
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10.h),
//
//               // زر الإضافة إلى السلة العلوي والنهائي
//               SizedBox(
//                 height: 60.h,
//                 width: 367.w,
//                 child: StoreElevatedBtn(
//                   value: "Add to cart",
//                   color: AppColor.mainColor,
//                   borderRadius: BorderRadius.circular(19).r,
//                   onPressed: () {
//                    Get.find<CartController>().addToCart(id);
//                   },
//                 ),
//               ),
//               SizedBox(height: 25.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:store_app/controllers/cart_controller.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/category-controller.dart';
import '../../controllers/whishlist_controller.dart';
import '../widgets/store_elevated_btn.dart';
import '../widgets/store_text.dart';


class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isExpanded = false;

  // 💡 جعل الكائن يقبل الـ null مؤقتاً لحماية الشاشة من الانهيار الفوري
  ProductData? product;
  int? id;

  final categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();

    // 💡 فحص الـ arguments وتأمينها داخل الـ initState بأمان
    if (Get.arguments != null && Get.arguments is ProductData) {
      product = Get.arguments as ProductData;
      id = product!.id;
      print("Product isFavorite: ${product!.isFavorite}");
      print("Product ID: $id");
    } else {
      print("⚠️ Error: ProductDetails opened without valid ProductData arguments!");
    }
  }

  @override
  Widget build(BuildContext context) {
    // 💡 إذا دخل المستخدم الصفحة وكانت البيانات مفقودة، نعرض واجهة حماية بدلاً من كراش باللون الأحمر
    if (product == null) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
        backgroundColor: Colors.white,
        body: const Center(
          child: Text(
            "Product data is unavailable.",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    // بمجرد تخطي الفحص، نقرأ البيانات باستخدام الـ (!) بأمان
    // سحب أول صورة متوفرة وتنظيف الرابط الخاص بها
    String cleanImgUrl = categoryController.getCleanImageUrl(
      (product!.images != null && product!.images!.isNotEmpty)
          ? product!.images![0]
          : product!.thumbnail,
    );

    return ScreenUtilInit(
      designSize: const Size(414, 896),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          elevation: 0,
          leading: InkWell(
            onTap: Get.back,
            child: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // حاوية الصورة الرئيسية مع حماية ضد الروابط المكسورة
              Container(
                width: 414.w,
                height: 300.h,
                decoration: BoxDecoration(
                  color: const Color(0xffF2F3F2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(19).r,
                    bottomRight: Radius.circular(19).r,
                  ),
                ),
                child: cleanImgUrl.isNotEmpty
                    ? Image.network(
                  cleanImgUrl,
                  width: 200.w,
                  fit: BoxFit.cover,
                  height: 350.h,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported, size: 50),
                )
                    : const Icon(Icons.image, size: 50),
              ),
              Padding(
                padding: EdgeInsets.all(20).r,
                child: Column(
                  children: [
                    // سكشن الاسم والوحدة والمفضلة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StoreText(
                                value: "${product!.name}",
                                color: const Color(0xff181725),
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                              ),
                              SizedBox(height: 5.h),
                              StoreText(
                                value: '${product!.unit}',
                                color: const Color(0xff7C7C7C),
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                            ],
                          ),
                        ),

                        // الـ GetBuilder الذي يقوم بالاستماع والتحديث اللحظي للون القلب
                        GetBuilder<FavoriteController>(
                          builder: (favoriteController) {
                            // 1. الفحص الذكي: هل المنتج متواجد في قائمة المفضلة المركزية؟
                            bool isFav = favoriteController.favoriteItems.any((item) => item.id == product!.id);

                            return InkWell(
                              onTap: () {
                                // 2. 💡 هنا يتم استدعاء الدالة السحرية التلقائية
                                // الدالة تفحص برمجياً: إذا كان أحمر ستحذفه وترجعه رمادي، وإذا كان رمادي ستضيفه وتلونه بالأحمر
                                favoriteController.toggleProductFavorite(product!);
                              },
                              child: SvgPicture.asset(
                                "${AppAsset.imageUrl}love.svg",
                                colorFilter: ColorFilter.mode(
                                  isFav ? Colors.red : const Color(0xff7C7C7C),
                                  BlendMode.srcIn,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.remove, color: const Color(0xffB3B3B3), size: 28.sp),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 45.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15).r,
                                border: Border.all(width: 1.w, color: const Color(0xffE2E2E2)),
                              ),
                              child: Text(
                                "1",
                                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add, color: const Color(0xff53B175), size: 28.sp),
                            ),
                          ],
                        ),
                        StoreText(
                          value: "${product!.finalUnitPrice}\$",
                          color: const Color(0xff181725),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const Divider(height: 1, color: Color(0xffE2E2E2)),
                    SizedBox(height: 15.h),

                    // سكشن تفاصيل المنتج القابل للتمدد (AnimatedCrossFade)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () => setState(() => isExpanded = !isExpanded),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StoreText(
                                value: "Product Details",
                                color: const Color(0xff181725),
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                              ),
                              AnimatedRotation(
                                duration: const Duration(milliseconds: 300),
                                turns: isExpanded ? 0.5 : 0,
                                child: const Icon(Icons.keyboard_arrow_down_sharp, size: 28),
                              ),
                            ],
                          ),
                        ),
                        AnimatedCrossFade(
                          firstChild: const SizedBox(width: double.infinity),
                          secondChild: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: StoreText(
                              value: categoryController.getCleanDetails(product!.details),
                              color: const Color(0xff7C7C7C),
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                          crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    const Divider(height: 1, color: Color(0xffE2E2E2)),
                    SizedBox(height: 15.h),

                    // سكشن القيمة الغذائية (Nutrition)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StoreText(
                          value: "Nutrition",
                          color: const Color(0xff181725),
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xffEBEBEB),
                                borderRadius: BorderRadius.circular(5).r,
                              ),
                              child: StoreText(
                                value: "100gr",
                                color: const Color(0xff7C7C7C),
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Icon(Icons.arrow_forward_ios_rounded, size: 16.sp, color: Colors.black),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    const Divider(height: 1, color: Color(0xffE2E2E2)),
                    SizedBox(height: 15.h),

                    // سكشن التقييمات (Review)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StoreText(
                          value: "Review",
                          color: const Color(0xff181725),
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                        Row(
                          children: [
                            ...List.generate(5, (index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              child: SvgPicture.asset("${AppAsset.imageUrl}star.svg", width: 15.w),
                            )),
                            SizedBox(width: 5.w),
                            Icon(Icons.arrow_forward_ios_rounded, size: 16.sp, color: Colors.black),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              // زر الإضافة إلى السلة
              SizedBox(
                height: 60.h,
                width: 367.w,
                child: StoreElevatedBtn(
                  value: "Add to cart",
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(19).r,
                  onPressed: () {
                    Get.find<CartController>().addToCart(id);
                  },
                ),
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}