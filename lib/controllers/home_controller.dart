import 'package:get/get.dart';
import '../core/localization/storaged_services.dart';
import 'cart_controller.dart'; // عدلي المسار حسب مشروعكِ

class HomeController extends GetxController {
  String country = "Select Zone";
  String city = "Location";

  final storage = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    updateLocationFromStorage();
fetchCartDataOnStart();
  }
  void fetchCartDataOnStart() {
    try {
      Get.find<CartController>().fetchCart();

      print("🛒 Cart data fetched successfully on app start.");
    } catch (e) {
      print("❌ Error fetching cart on start: $e");
    }
  }
  /// دالة لإعادة سحب قيم الموقع من الستورج وتنبيه الـ UI لإعادة الرسم فوراً
  void updateLocationFromStorage() {
    // استخدمتُ المفاتيح الحالية الخاصة بكِ (zone و area) لضمان القراءة الصحيحة
    country = storage.read('zone') ?? "Select Zone";
    city = storage.read('area') ?? "Location";
    update(); // 🔥 لتحديث كافة واجهات الـ GetBuilder الاستماعية لحظياً
  }
}