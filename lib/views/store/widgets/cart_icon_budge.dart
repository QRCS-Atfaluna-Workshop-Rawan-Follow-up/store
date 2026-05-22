import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:store_app/core/theme/app_color.dart';
import '../../../controllers/cart_controller.dart'; // 💡 تأكدي من مسار الكنترولر الصحيح عندكِ
import '../../../routes/app_routes.dart';

class CartBadgeIcon extends StatelessWidget {
  const CartBadgeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (cartController) {
        int itemsCount = cartController.cartItems.length;
        return Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.cart);
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xff181725),
                size: 30.r,
              ),
            ),

            // 2. الدائرة الحمراء (تظهر فقط إذا كان هناك منتجات في السلة)
            if (itemsCount > 0)
              Positioned(
                right:10.w,
                top: 4.h,
                child: Container(
                  padding:  EdgeInsets.all(5).r,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5.w), // إطار أبيض لتبرز الأيقونة
                  ),
                  constraints: BoxConstraints(
                    minWidth: 20.w,
                    minHeight: 20.h,
                  ),
                  child: Center(
                    child: Text(
                      "$itemsCount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}