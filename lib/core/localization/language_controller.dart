import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store_app/core/localization/storaged_services.dart';

class LanguageController extends GetxController {
  final storage = Get.find<StorageService>();

  late Rx<Locale> currentLocale;
  @override
  void onInit() {
    // Locale? initialLang = storage.read('languageCode') == null ? Get.deviceLocale : Locale(storage.read('languageCode')); using device language
    String lang = storage.read('languageCode') ?? 'en';
    String country = storage.read('countryCode') ?? 'US';
    currentLocale = Locale(lang, country).obs;
    super.onInit();
  }

  bool get isArabic => currentLocale.value.languageCode == 'ar';

  void updateLocale(String langCode, String countryCode) {
    Locale newLocale = Locale(langCode, countryCode);
    Get.updateLocale(newLocale); //update on getx level
    currentLocale.value = newLocale;

    storage.write('languageCode', langCode);
    storage.write('countryCode', countryCode);
  }
}

