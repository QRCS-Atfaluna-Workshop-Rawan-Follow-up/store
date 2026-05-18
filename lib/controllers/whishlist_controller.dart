import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../core/localization/storaged_services.dart';
import '../data/models/whishlist_model.dart';


class FavoriteController extends GetxController {
  // قائمة لتخزين المنتجات المفضلة
  List<FavoriteProduct> favoriteItems = [];

  // الحصول على التوكن من التخزين المحلي
  String? get token => Get.find<StorageService>().read('token');

  @override
  void onInit() {
    super.onInit();
    fetchFavorites(); // جلب البيانات فور تشغيل الكنترولر
  }

  Future<void> fetchFavorites() async {
    if (token == null) return;

    EasyLoading.show(status: 'جاري تحميل المفضلة...');

    try {
      final response = await http.get(
        Uri.parse("https://tullana.toldpath.com/api/customer/favorites"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          // تحويل البيانات باستخدام الموديل الشامل
          FavoriteResponse favoriteData = FavoriteResponse.fromJson(jsonResponse);

          // تحديث القائمة المحلية
          favoriteItems.clear();
          if (favoriteData.data != null) {
            favoriteItems.addAll(favoriteData.data!);
          }

          print("تم جلب المفضلة: ${favoriteItems.length} منتج");
        }
      } else {
        print("خطأ في السيرفر: ${response.statusCode}");
      }
    } catch (e) {
      print("Error Fetching Favorites: $e");
      EasyLoading.showError("فشل في تحميل القائمة");
    } finally {
      update(); // تحديث الواجهة (GetBuilder)
      EasyLoading.dismiss();
    }
  }
  Future<void> addToFavorites(int? productId) async {
    if (productId == null) return;

    EasyLoading.show(status: 'جاري الإضافة للمفضلة...');

    try {
      final response = await http.post(
        Uri.parse("https://tullana.toldpath.com/api/customer/favorites/add"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'product_id': productId.toString(),
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        // تحديث البيانات لجلب القائمة الجديدة التي تحتوي المنتج المضاف
        await fetchFavorites();

        EasyLoading.showSuccess(data['message'] ?? "تمت الإضافة بنجاح");
      } else {
        EasyLoading.showError(data['message'] ?? "فشل في الإضافة");
      }
    } catch (e) {
      print("Add to Wishlist Error: $e");
      EasyLoading.showError("خطأ في الاتصال");
    } finally {
      update(); // تحديث الواجهة فوراً
    }
  }
  // Future<void> removeFromFavorites(int? productId) async {
  //   if (productId == null) return;
  //   EasyLoading.show(status: 'جاري الحذف من المفضلة...');
  //   try {
  //     final response = await http.delete(
  //       Uri.parse("https://tullana.toldpath.com/api/customer/favorites/remove"),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: {
  //         'product_id': productId.toString(),
  //       },
  //     );
  //     var data = json.decode(response.body);
  //     if (response.statusCode == 200 && data['status'] == true) {
  //       // ✅ تحديث القائمة المحلية فوراً بعد الحذف لضمان اختفاء المنتج من الشاشة
  //       await fetchFavorites();
  //       EasyLoading.showSuccess(data['message'] ?? "تم الحذف بنجاح");
  //     } else {
  //       EasyLoading.showError(data['message'] ?? "فشل الحذف");
  //     }
  //   } catch (e) {
  //     print("Remove from Wishlist Error: $e");
  //     EasyLoading.showError("خطأ في الاتصال");
  //   } finally {
  //     // ✅ تحديث الواجهة (إعادة رسم الـ GetBuilder)
  //     update();
  //   }
  //
  // }
  Future<void> removeFromFavorites(int? productId) async {
    if (productId == null || token == null) return;

    EasyLoading.show(status: 'جاري الحذف...');

    try {
      // 1. إنشاء الطلب وتحديد النوع DELETE
      var request = http.Request(
          'DELETE',
          Uri.parse("https://tullana.toldpath.com/api/customer/favorites/remove")
      );

      // 2. إضافة الـ Headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json', // ضروري لأن البيانات تُرسل كـ JSON
        'Authorization': 'Bearer $token',
      });

      request.body = json.encode({
        'product_id': [productId] , // إرساله كـ int أو String حسب ما يطلبه السير
      });


      // 4. إرسال الطلب
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        // ✅ حذف المنتج من القائمة المحلية فوراً لتحسين تجربة المستخدم
        favoriteItems.removeWhere((item) => item.id == productId);
        update(); // تحديث GetBuilder

        EasyLoading.showSuccess(data['message'] ?? "تم الحذف بنجاح");
      } else {
        EasyLoading.showError(data['message'] ?? "فشل الحذف");
      }
    } catch (e) {
      print("Remove Error: $e");
      EasyLoading.showError("خطأ في الاتصال");
    } finally {
      update();
    }
  }
}