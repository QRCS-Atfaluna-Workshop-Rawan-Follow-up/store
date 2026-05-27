import 'dart:convert';
import 'package:flutter/material.dart'; // استخدمي material بدلاً من cupertino لدعم التكست كنترولر بشكل أفضل
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/core/constant/api_contants.dart';
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

  }

  String? get token => Get.find<StorageService>().read('token');

  // دالة تعبئة الحقول (تم حذف Get.toNamed منها لتجنب التكرار)
  // void fillFieldsForUpdate(AddressData address) {
  //   updatingAddressId = address.id; // حفظ الـ ID لاستخدامه في دالة الـ update
  //   titleController.text = address.title ?? "";
  //   recipientController.text = address.recipientName ?? "";
  //   cityController.text = address.city ?? "";
  //   areaController.text = address.area ?? "";
  //   streetController.text = address.street ?? "";
  //   buildingController.text = address.buildingNumber ?? "";
  //   phoneController.text = address.mobile ?? "";
  //   update();
  // }

  // دالة الإضافة (Submit)
  Future<bool> addNewAddress(
      {
    required String addressType,
    required String recipientName,
    required String city,
    required String block,
    required String buildingNumber,
    required String countryCode,
    required String mobile,
    required String latitude,
    required String longitude,
    required String area,
  })
  async {
    try {
      EasyLoading.show(status: 'جاري حفظ العنوان...');

      // 🎯 استخدام MultipartRequest لأن السيرفر يتوقع form-data
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstants.addAddress),
      );

      // إضافة الـ Headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token', // تأكدي من تمرير التوكن الخاص بكِ
      });

      // 📜 إضافة الحقول بأسماء الـ Keys المطابقة تماماً لـ Postman
      request.fields['address_type'] = addressType;
      request.fields['recipient_name'] = recipientName;
      request.fields['city'] = city;
      request.fields['block'] = block;
      request.fields['building_number'] = buildingNumber;
      request.fields['country_code'] = countryCode;
      request.fields['mobile'] = mobile;
      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;
      request.fields['area'] = area;

      // إرسال الطلب واستقبال الرد
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        EasyLoading.showSuccess("تم إضافة العنوان بنجاح");
        return true;
      } else {
        EasyLoading.showError("فشل الإضافة: ${data['message'] ?? ''}");
        return false;
      }
    } catch (e) {
      print("Error adding address: $e");
      EasyLoading.showError("حدث خطأ في الاتصال");
      return false;
    }
  }

  // دالة التحديث (Update) - ضيفيها عندك
// داخل AddressController
  Future<void> updateAddress({
    required int id,
    required String title,
    required String recipientName,
    required int block,
    required int buildingNumber,
    required String city,
    required String area,
    required String mobile,
  }) async
  {
    try {
      EasyLoading.show(status: 'Updating...');

      // تأكدي من مسار الـ API الصحيح للتعديل
      var response = await http.put(
        Uri.parse(
            ApiConstants.updateAddress),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        },
        body: {
          'id': id.toString(),
          'title': title,
          'block': block.toString(),
          'building_number': buildingNumber.toString(),
          'recipient_name': recipientName,
          'city': city,
          'area': area,
          'mobile': mobile,
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        EasyLoading.showSuccess("Updated successfully");
        Get.back(result: true);
      } else {
        EasyLoading.showError(data['message'] ?? "Update failed");
      }
    } catch (e) {
      EasyLoading.showError("Connection error");
    }
  }
  bool isLoading = false;

  List<AddressModel> addressList = []; // ✅ تم تعديل الاسم ليتطابق مع الموديل (AddressModel)

  Future<void> fetchAddresses() async {
    try {
      isLoading = true;
      update(); // تحديث الواجهة لإظهار مؤشر التحميل

      final response = await http.get(
        Uri.parse(ApiConstants.addressList),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // تأكدي من تعريف متغير الـ token لديكِ
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        if (data['data'] != null) {
          Iterable list = data['data'];
          // ✅ تحويل البيانات بأمان كلياً بناءً على الموديل الجديد AddressModel
          addressList = list.map((model) => AddressModel.fromJson(model)).toList();
        } else {
          addressList = [];
        }
      } else {
        // أضفت تلميحاً في حال لم يرسل السيرفر رسالة خطأ صريحة
        String message = data['message'] ?? "خطأ غير معروف";
        EasyLoading.showError("فشل جلب العناوين: $message");
      }
    } catch (e) {
      print("Error fetching addresses: $e");
      EasyLoading.showError("حدث خطأ في الاتصال");
    } finally {
      isLoading = false;
      update(); // تحديث الواجهة لإخفاء مؤشر التحميل وعرض البيانات الحية
    }
  }

  // Future<void> deleteAddress(int addressId) async {
  //   try {
  //     EasyLoading.show(status: 'جاري الحذف...');
  //
  //     final response = await http.delete(
  //       Uri.parse("https://tullana.toldpath.com/api/customer/profile/address/delete/$addressId"),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //
  //     var data = json.decode(response.body);
  //
  //     if (response.statusCode == 200 && data['status'] == true) {
  //       // حذف العنصر من القائمة المحلية فوراً لتحديث الواجهة بسرعة
  //       addressList.removeWhere((element) => element.id == addressId);
  //       update();
  //
  //       EasyLoading.showSuccess("تم حذف العنوان بنجاح");
  //     } else {
  //       EasyLoading.showError("فشل الحذف: ${data['message']}");
  //     }
  //   } catch (e) {
  //     EasyLoading.showError("حدث خطأ أثناء الحذف");
  //   }
  // }
  }