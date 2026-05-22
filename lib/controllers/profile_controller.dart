import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../core/localization/storaged_services.dart';
import '../data/models/profile_model.dart';

class ProfileController extends GetxController {
  // متغير لتخزين بيانات المستخدم
  UserData? currentUser;

  String? get token => Get.find<StorageService>().read('token');

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile(); // جلب البيانات فور تشغيل الكنترولر
  }

  Future<void> fetchUserProfile() async {
    if (token == null) return;

    EasyLoading.show(status: 'جاري تحميل بياناتك...');

    try {
      final response = await http.get(
        Uri.parse("https://tullana.toldpath.com/api/customer/profile/info"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          // تحويل الـ JSON إلى الموديل الذي أنشأناه
          UserModel userModel = UserModel.fromJson(jsonResponse);

          // تخزين بيانات المستخدم في المتغير المحلي
          currentUser = userModel.user;

          print("تم جلب بيانات المستخدم: ${currentUser?.name}");
        }
      } else {
        print("خطأ في السيرفر: ${response.statusCode}");
      }
    } catch (e) {
      print("Error Fetching Profile: $e");
      EasyLoading.showError("فشل في جلب البيانات");
    } finally {
      update(); // تحديث الواجهة (UI)
      EasyLoading.dismiss();
    }
  }
  // داخل
  Future<void> updateUserName({ required String firstName ,
    required String lastName ,required String email,required String countryCode ,required String phoneNumber}) async {
    if (firstName.isEmpty) return;

    EasyLoading.show(status: 'جاري التحديث...');
    try {
      final response = await http.post(
        Uri.parse("https://tullana.toldpath.com/api/customer/profile/update-profile"), // تأكدي من مسار الرابط من الـ API
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'first_name': firstName,
          'last_name': lastName,
          "email":email,
          "mobile" : phoneNumber,
          'country_code' : countryCode
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        // تحديث البيانات محلياً في الكنترولر لتظهر فوراً على الشاشة
        currentUser?.firstName = firstName;
        currentUser?.lastName = lastName;
        currentUser?.email = email;
        currentUser?.phone = phoneNumber;
        update();
        EasyLoading.showSuccess("تم تحديث الاسم بنجاح");
      } else {
        EasyLoading.showError("فشل التحديث");
      }
    } catch (e) {
      EasyLoading.showError("خطأ في الاتصال");
    }
  }
}