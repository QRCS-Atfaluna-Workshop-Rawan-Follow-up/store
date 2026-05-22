import 'package:get/get.dart';
import 'language_controller.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {
        'en_US': {
          'cart': 'Cart',
          "Go to Checkout": "Go to Checkout"
        },
        'ar_SA': {
          "cart":"السلة",
          "setting": "اعدادات",
          "Go to Checkout": "الذهاب لصفحة الدفع"
        },
      };
}