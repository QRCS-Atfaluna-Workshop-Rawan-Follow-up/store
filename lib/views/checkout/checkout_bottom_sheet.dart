import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/routes/app_routes.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/checkout_contoller.dart';

class CheckoutBottomSheet extends StatelessWidget {
  const CheckoutBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // حقن الكنترولر الخاص بالـ Checkout عند فتح الشاشة
    final CheckoutController checkoutController = Get.put(CheckoutController());

    return GetBuilder<CartController>(
      builder: (cartController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF2F3F2), // اللون الخلفي الفاتح للتصميم
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min, // ليأخذ الارتفاع المناسب للمحتوى فقط
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الـ Header: العنوان وزر الإغلاق
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Checkout",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF181725),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFF181725)),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(height: 1, color: Color(0xFFE2E2E2)),

              // 1. خيار التوصيل (Delivery)
              Obx(() => _buildCheckoutRow(
                title: "Delivery",
                trailing: Text(
                  checkoutController.selectedDelivery.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF181725),
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  // محاكاة سريعة لاختيار التوصيل وتحديث السعر بـ 5 دولار
                  checkoutController.updateDelivery("Express (\$5.00)", 5.0);
                },
              )),

              // 2. خيار الدفع (Payment)
              Obx(() => _buildCheckoutRow(
                title: "Payment",
                trailing: checkoutController.selectedPayment.value == "MasterCard"
                    ? const Icon(Icons.credit_card, color: Colors.blue) // يمكنك استبدالها بصورة الماستر كارد لاحقاً
                    : Text(checkoutController.selectedPayment.value),
                onTap: () {
                  // شاشة أو ديالوج لإدارة بطاقات الدفع
                },
              )),

              // 3. كود الخصم (Promo Code)
              Obx(() => _buildCheckoutRow(
                title: "Promo Code",
                trailing: Text(
                  checkoutController.promoCode.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF181725),
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  // محاكاة تطبيق كود خصم 10% عند الضغط
                  checkoutController.applyPromoCode("DISCOUNT10 (10%)", 0.10);
                },
              )),

              // 4. التكلفة الإجمالية الحية والمحدثة من السيرفر (Total Cost)
              Obx(() => _buildCheckoutRow(
                title: "Total Cost",
                trailing: Text(
                  "\$${checkoutController.totalCost.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF181725),
                    fontSize: 16,
                  ),
                ),
                onTap: () {},
              )),

              const SizedBox(height: 15),

              // نصوص الشروط والأحكام الثابتة
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Color(0xFF7C7C7C), fontSize: 14, height: 1.4),
                  children: [
                    TextSpan(text: "By placing an order you agree to our\n"),
                    TextSpan(
                      text: "Terms ",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF181725)),
                    ),
                    TextSpan(text: "And "),
                    TextSpan(
                      text: "Conditions",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF181725)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // زر إتمام الطلب الرئيسي (Place Order)
              SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    // هنا يتم إرسال طلب الشراء النهائي مع القيم المختارة
                    print("تم إرسال الطلب بنجاح بإجمالي: ${checkoutController.totalCost}");
                    Get.toNamed(AppRoutes.orderAccept);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xFF53B175), // لون التصميم الأخضر المميز
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Place Order",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ويدجيت مساعدة ومكررة لأسطر الخيارات لضمان كود نظيف وقابل للصيانة
  Widget _buildCheckoutRow({
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 18.0),
            child: Row(
              children: [
                Text(
                  title,
                  style:  TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7C7C7C),
                  ),
                ),
                 Spacer(),
                trailing,
                 SizedBox(width: 12),
                 Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF181725),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E2E2)),
        ],
      ),
    );
  }
}