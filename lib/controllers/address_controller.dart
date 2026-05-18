import 'dart:convert';
import 'package:flutter/material.dart'; // استخدمي material بدلاً من cupertino لدعم التكست كنترولر بشكل أفضل
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../core/localization/storaged_services.dart';
import '../data/models/adress_model.dart';

class AddressController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController recipientController;
  late TextEditingController cityController;
  late TextEditingController areaController;
  late TextEditingController streetController;
  late TextEditingController buildingController;
  late TextEditingController phoneController;

  // متغير لحفظ الـ ID عند التعديل
  int? updatingAddressId;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    recipientController = TextEditingController();
    cityController = TextEditingController();
    areaController = TextEditingController();
    streetController = TextEditingController();
    buildingController = TextEditingController();
    phoneController = TextEditingController();

    // هنا السحر: أول ما تفتح الصفحة، لو فيه بيانات (تعديل) بتنزل في الحقول

  }
  @override
  void onReady() {
    super.onReady();
    // التأكد من استقبال البيانات بعد جاهزية الصفحة تماماً
    if (Get.arguments != null && Get.arguments is AddressData) {
      fillFieldsForUpdate(Get.arguments);
    }
  }
  @override
  void onClose() {
    // يفضل عمل dispose لكل الكنترولرز للحفاظ على أداء الجهاز
    titleController.dispose();
    recipientController.dispose();
    cityController.dispose();
    areaController.dispose();
    streetController.dispose();
    buildingController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  String? get token => Get.find<StorageService>().read('token');

  // دالة تعبئة الحقول (تم حذف Get.toNamed منها لتجنب التكرار)
  void fillFieldsForUpdate(AddressData address) {
    updatingAddressId = address.id; // حفظ الـ ID لاستخدامه في دالة الـ update
    titleController.text = address.title ?? "";
    recipientController.text = address.recipientName ?? "";
    cityController.text = address.city ?? "";
    areaController.text = address.area ?? "";
    streetController.text = address.street ?? "";
    buildingController.text = address.buildingNumber ?? "";
    phoneController.text = address.mobile ?? "";
    update();
  }

  // دالة الإضافة (Submit)
  Future<void> submitAddress({
    required String title,required String recipientName,required String city,
    required String area, required String street,
    required String buildingNumber, required String mobile,
    required String addressType,required String countryCode,
}) async {
    try {
      EasyLoading.show(status: 'جاري الحفظ...');
      final response = await http.post(
        Uri.parse("https://tullana.toldpath.com/api/customer/profile/address/add"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "title": titleController.text,
          "recipient_name": recipientController.text,
          "city": cityController.text,
          "area": areaController.text,
          "street": streetController.text,
          "building_number": buildingController.text,
          "mobile": phoneController.text,
          "address_type": "Home",
          "country_code": "+966",
        },
      );

      var data = json.decode(response.body);
      if (response.statusCode == 200 && data['status'] == true) {
        EasyLoading.showSuccess("تمت الإضافة بنجاح");
        Get.back(result: true); // العودة للخلف مع إرجاع قيمة لتحديث القائمة
      } else {
        EasyLoading.showError("خطأ: ${data['message']}");
      }
    } catch (e) {
      EasyLoading.showError("تعذر الاتصال");
    }
  }

  // دالة التحديث (Update) - ضيفيها عندك
// داخل AddressController
  Future<void> updateAddress({
    required int id,
    required String title,
    required String recipientName,
    required String city,
    required String area,
    required String mobile,
  }) async {
    try {
      EasyLoading.show(status: 'جاري التعديل...');

      // تأكدي من مسار الـ API الصحيح للتعديل
      var response = await http.post(
        Uri.parse(
            "https://tullana.toldpath.com/api/customer/profile/address/update/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'title': title,
          'recipient_name': recipientName,
          'city': city,
          'area': area,
          'mobile': mobile,
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        EasyLoading.showSuccess("تم التعديل بنجاح");

        // السطر الأهم: العودة للصفحة السابقة مع إشارة نجاح
        Get.back(result: true);
      } else {
        EasyLoading.showError(data['message'] ?? "فشل التعديل");
      }
    } catch (e) {
      EasyLoading.showError("خطأ في الاتصال");
    }
  }  bool isLoading = false;
  List<AddressData> addressList = [];

  // bool isLoading = false; // متغير لمتابعة حالة التحميل
  // List<AddressData> addressList = []; // القائمة التي ستعرض في الواجهة

  Future<void> fetchAddresses() async {
    try {
      isLoading = true;
      update(); // تحديث الواجهة لإظهار مؤشر التحميل

      final response = await http.get(
        Uri.parse("https://tullana.toldpath.com/api/customer/profile/address/list"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // تأكدي أن التوكن موجود
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        // تحويل البيانات القادمة من JSON إلى قائمة من موديل AddressData
        Iterable list = data['data'];
        addressList = list.map((model) => AddressData.fromJson(model)).toList();
      } else {
        EasyLoading.showError("فشل جلب العناوين: ${data['message']}");
      }
    } catch (e) {
      print("Error fetching addresses: $e");
      EasyLoading.showError("حدث خطأ في الاتصال");
    } finally {
      isLoading = false;
      update(); // تحديث الواجهة لإخفاء مؤشر التحميل وعرض البيانات
    }}

  Future<void> deleteAddress(int addressId) async {
    try {
      EasyLoading.show(status: 'جاري الحذف...');

      final response = await http.delete(
        Uri.parse("https://tullana.toldpath.com/api/customer/profile/address/delete/$addressId"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        // حذف العنصر من القائمة المحلية فوراً لتحديث الواجهة بسرعة
        addressList.removeWhere((element) => element.id == addressId);
        update();

        EasyLoading.showSuccess("تم حذف العنوان بنجاح");
      } else {
        EasyLoading.showError("فشل الحذف: ${data['message']}");
      }
    } catch (e) {
      EasyLoading.showError("حدث خطأ أثناء الحذف");
    }
  }
  }