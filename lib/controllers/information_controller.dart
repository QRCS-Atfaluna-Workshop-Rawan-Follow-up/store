import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:store_app/core/localization/storaged_services.dart';
import 'package:store_app/core/network/api_contants.dart';
class InformationController extends GetxController {
  // متغيرات صفحة من نحن
  String aboutUsContent = "";
  bool isAboutLoading = true;

  // متغيرات صفحة الشروط والأحكام
  String termsContent = "";
  bool isTermsLoading = true;

  String privacyContent = "";
  bool isPrivacyLoading = true;

  // داخل الكنترولر قبل استدعاء الـ API
  String? get token => Get.find<StorageService>().read('token');  // دالة جلب بيانات "من نحن"

  Future<void> fetchAboutUs() async {
    try {
      isAboutLoading = true;
      update();
      final response = await http.get(
          Uri.parse(ApiConstants.aboutUs));
      if (response.statusCode == 200) {
        aboutUsContent = json.decode(response.body)['data'] ?? "";
      }
    } catch (e) {
      aboutUsContent = "<p>فشل تحميل البيانات.</p>";
    } finally {
      isAboutLoading = false;
      update();
    }
  }

  // دالة جلب بيانات "الشروط والأحكام"
  Future<void> fetchTerms() async {
    try {
      isTermsLoading = true;
      update();
      final response = await http.get(Uri.parse(ApiConstants.terms));
      if (response.statusCode == 200) {
        termsContent = json.decode(response.body)['data'] ?? "";
      }
    } catch (e) {
      termsContent = "<p>فشل تحميل الشروط.</p>";
    } finally {
      isTermsLoading = false;
      update();
    }
  }

  // دالة جلب سياسة الخصوصية
  Future<void> fetchPrivacy() async {
    try {
      isPrivacyLoading = true;
      update();
      final response = await http.get(Uri.parse(ApiConstants.privacy));
      if (response.statusCode == 200) {
        privacyContent = json.decode(response.body)['data'] ?? "";
      }
    } catch (e) {
      privacyContent = "<p style='text-align:center;'>فشل تحميل سياسة الخصوصية.</p>";
    } finally {
      isPrivacyLoading = false;
      update();
    }
  }

  Future<void> submitTicket({required String subject, required String description,}) async {
    try {
      EasyLoading.show(status: 'sending your message...');

      final response = await http.post(
        Uri.parse(ApiConstants.support),
        body: {
          "issue_type": subject,
          "description": description,

        },
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      var decodedData = json.decode(response.body);
      if (response.statusCode == 200 && decodedData['status'] == true) {
        EasyLoading.showSuccess(decodedData['message']);
        Future.delayed(const Duration(seconds: 1), () => Get.back());
      } else {
        EasyLoading.showError('sending is failed${decodedData['message'] ?? 'Error'}');
      }
    } catch (e) {
      EasyLoading.showError('تعذر الاتصال بالخادم');
    }
  }

}