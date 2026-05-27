import 'package:get/get.dart';
import '../core/localization/storaged_services.dart';
import 'cart_controller.dart';

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
  void updateLocationFromStorage() {
    country = storage.read('zone') ?? "Select Zone";
    city = storage.read('area') ?? "Location";
    update();
  }
}