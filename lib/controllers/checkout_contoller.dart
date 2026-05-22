import 'package:get/get.dart';

import 'cart_controller.dart';

class CheckoutController extends GetxController {
  final CartController cartController = Get.find<CartController>();
  double subTotal = 0.0;

  // متغيرات تفاعلية لتخزين اختيارات المستخدم
  var selectedDelivery = "Select Method".obs;
  var deliveryCost = 0.0.obs;

  var selectedPayment = "MasterCard".obs;
  var promoCode = "Pick discount".obs;
  var discountPercentage = 0.0.obs;



  // 3. حساب التكلفة الكلية النهائية تلقائياً (السعر من السيرفر + التوصيل - الخصم)
  double get totalCost {
    double discountAmount = subTotal * discountPercentage.value;
    return subTotal + deliveryCost.value - discountAmount;
  }

  void updateDelivery(String method, double cost) {
    selectedDelivery.value = method;
    deliveryCost.value = cost;
  }

  void applyPromoCode(String code, double discount) {
    promoCode.value = code;
    discountPercentage.value = discount;
  }
}
