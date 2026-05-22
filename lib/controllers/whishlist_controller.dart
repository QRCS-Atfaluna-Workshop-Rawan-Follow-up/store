// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
//
// import '../core/localization/storaged_services.dart';
// import '../data/models/whishlist_model.dart';
//
//
// class FavoriteController extends GetxController {
//   // قائمة لتخزين المنتجات المفضلة
//   List<FavoriteProduct> favoriteItems = [];
//
//   // الحصول على التوكن من التخزين المحلي
//   String? get token => Get.find<StorageService>().read('token');
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchFavorites(); // جلب البيانات فور تشغيل الكنترولر
//   }
//
//   Future<void> fetchFavorites() async {
//     if (token == null) return;
//
//     EasyLoading.show(status: 'جاري تحميل المفضلة...');
//
//     try {
//       final response = await http.get(
//         Uri.parse("https://tullana.toldpath.com/api/customer/favorites"),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//
//         if (jsonResponse['status'] == true) {
//           // تحويل البيانات باستخدام الموديل الشامل
//           FavoriteResponse favoriteData = FavoriteResponse.fromJson(jsonResponse);
//
//           // تحديث القائمة المحلية
//           favoriteItems.clear();
//           if (favoriteData.data != null) {
//             favoriteItems.addAll(favoriteData.data!);
//           }
//
//           print("تم جلب المفضلة: ${favoriteItems.length} منتج");
//         }
//       } else {
//         print("خطأ في السيرفر: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error Fetching Favorites: $e");
//       EasyLoading.showError("فشل في تحميل القائمة");
//     } finally {
//       update(); // تحديث الواجهة (GetBuilder)
//       EasyLoading.dismiss();
//     }
//   }
//   Future<void> addToFavorites(int? productId) async {
//     if (productId == null) return;
//
//     EasyLoading.show(status: 'جاري الإضافة للمفضلة...');
//
//     try {
//       final response = await http.post(
//         Uri.parse("https://tullana.toldpath.com/api/customer/favorites/add"),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: {
//           'product_id': productId.toString(),
//         },
//       );
//
//       var data = json.decode(response.body);
//
//       if (response.statusCode == 200 && data['status'] == true) {
//         // تحديث البيانات لجلب القائمة الجديدة التي تحتوي المنتج المضاف
//         await fetchFavorites();
//
//         EasyLoading.showSuccess(data['message'] ?? "تمت الإضافة بنجاح");
//       } else {
//         EasyLoading.showError(data['message'] ?? "فشل في الإضافة");
//       }
//     } catch (e) {
//       print("Add to Wishlist Error: $e");
//       EasyLoading.showError("خطأ في الاتصال");
//     } finally {
//       update(); // تحديث الواجهة فوراً
//     }
//   }
//   // Future<void> removeFromFavorites(int? productId) async {
//   //   if (productId == null) return;
//   //   EasyLoading.show(status: 'جاري الحذف من المفضلة...');
//   //   try {
//   //     final response = await http.delete(
//   //       Uri.parse("https://tullana.toldpath.com/api/customer/favorites/remove"),
//   //       headers: {
//   //         'Accept': 'application/json',
//   //         'Authorization': 'Bearer $token',
//   //       },
//   //       body: {
//   //         'product_id': productId.toString(),
//   //       },
//   //     );
//   //     var data = json.decode(response.body);
//   //     if (response.statusCode == 200 && data['status'] == true) {
//   //       // ✅ تحديث القائمة المحلية فوراً بعد الحذف لضمان اختفاء المنتج من الشاشة
//   //       await fetchFavorites();
//   //       EasyLoading.showSuccess(data['message'] ?? "تم الحذف بنجاح");
//   //     } else {
//   //       EasyLoading.showError(data['message'] ?? "فشل الحذف");
//   //     }
//   //   } catch (e) {
//   //     print("Remove from Wishlist Error: $e");
//   //     EasyLoading.showError("خطأ في الاتصال");
//   //   } finally {
//   //     // ✅ تحديث الواجهة (إعادة رسم الـ GetBuilder)
//   //     update();
//   //   }
//   //
//   // }
//   Future<void> removeFromFavorites(int? productId) async {
//     if (productId == null || token == null) return;
//
//     EasyLoading.show(status: 'جاري الحذف...');
//
//     try {
//       // 1. إنشاء الطلب وتحديد النوع DELETE
//       var request = http.Request(
//           'DELETE',
//           Uri.parse("https://tullana.toldpath.com/api/customer/favorites/remove")
//       );
//
//       // 2. إضافة الـ Headers
//       request.headers.addAll({
//         'Accept': 'application/json',
//         'Content-Type': 'application/json', // ضروري لأن البيانات تُرسل كـ JSON
//         'Authorization': 'Bearer $token',
//       });
//
//       request.body = json.encode({
//         'product_id': [productId] , // إرساله كـ int أو String حسب ما يطلبه السير
//       });
//
//
//       // 4. إرسال الطلب
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//
//       var data = json.decode(response.body);
//
//       if (response.statusCode == 200 && data['status'] == true) {
//         // ✅ حذف المنتج من القائمة المحلية فوراً لتحسين تجربة المستخدم
//         favoriteItems.removeWhere((item) => item.id == productId);
//         update(); // تحديث GetBuilder
//
//         EasyLoading.showSuccess(data['message'] ?? "تم الحذف بنجاح");
//       } else {
//         EasyLoading.showError(data['message'] ?? "فشل الحذف");
//       }
//     } catch (e) {
//       print("Remove Error: $e");
//       EasyLoading.showError("خطأ في الاتصال");
//     } finally {
//       update();
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'cart_controller.dart';
import '../core/localization/storaged_services.dart';
import '../data/models/whishlist_model.dart';
import 'category-controller.dart';

class FavoriteController extends GetxController {
  // List to store favorite products
  List<FavoriteProduct> favoriteItems = [];

  // Get token from local storage
  String? get token => Get.find<StorageService>().read('token');

  @override
  void onInit() {
    super.onInit();
    fetchFavorites(); // Fetch data automatically on init
  }

  /// Fetches the updated list of favorites from the server
  Future<void> fetchFavorites() async {
    if (token == null) return;

    EasyLoading.show(status: 'Loading wishlist...');

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
          FavoriteResponse favoriteData = FavoriteResponse.fromJson(jsonResponse);

          // Update local list
          favoriteItems.clear();
          if (favoriteData.data != null) {
            favoriteItems.addAll(favoriteData.data!);
          }

          print("Favorites fetched: ${favoriteItems.length} products");
        }
      } else {
        print("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error Fetching Favorites: $e");
      EasyLoading.showError("Failed to load wishlist");
    } finally {
      update(); // Update UI (GetBuilder)
      EasyLoading.dismiss();
    }
  }

  /// Handles Toggling Favorite Status (Adds or Removes based on current list state)
  Future<void> toggleProductFavorite(ProductData product) async {
    if (product.id == null || token == null) return;

    // 💡 فحص وجود المنتج داخل القائمة المركزية لمعرفة الإجراء المناسب (حذف أم إضافة)
    int localIndex = favoriteItems.indexWhere((item) => item.id == product.id);
    bool isCurrentlyFavorite = localIndex != -1;

    if (isCurrentlyFavorite) {
      // -----------------------------------------------------------
      // إجراء الحذف (إذا كان المنتج موجوداً مسبقاً وضغطتِ عليه ليختفي)
      // -----------------------------------------------------------

      // 1. تحديث محلي فوري واستهداف الـ UI مباشرة
      favoriteItems.removeAt(localIndex);
      product.isFavorite = false;
      update(); // تحديث الـ GetBuilder فوراً ليتحول القلب للرمادي

      EasyLoading.show(status: 'Removing from wishlist...');
      try {
        var request = http.Request(
            'DELETE',
            Uri.parse("https://tullana.toldpath.com/api/customer/favorites/remove")
        );

        request.headers.addAll({
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });

        request.body = json.encode({
          'product_id': [product.id],
        });

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);
        var data = json.decode(response.body);

        if (response.statusCode == 200 && data['status'] == true) {
          EasyLoading.showSuccess(data['message'] ?? "Removed successfully");
        } else {
          // التراجع محلياً في حال فشل استجابة السيرفر لضمان سلامة البيانات
          await fetchFavorites();
          EasyLoading.showError(data['message'] ?? "Failed to remove");
        }
      } catch (e) {
        await fetchFavorites();
        EasyLoading.showError("Connection error");
      }
    } else {
      // -----------------------------------------------------------
      // إجراء الإضافة (إذا كان المنتج غير موجود وضغطتِ عليه ليُضاف)
      // -----------------------------------------------------------

      // 1. تحديث محلي فوري وتحويل لون القلب للأحمر دون انتظار الشبكة
      favoriteItems.add(FavoriteProduct(
        id: product.id,
        name: product.name,
        thumbnail: product.thumbnail,
        finalUnitPrice: product.finalUnitPrice,
      ));
      product.isFavorite = true;
      update(); // تحديث الـ GetBuilder فوراً ليتحول القلب للأحمر

      EasyLoading.show(status: 'Adding to wishlist...');
      try {
        final response = await http.post(
          Uri.parse("https://tullana.toldpath.com/api/customer/favorites/add"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: {
            'product_id': product.id.toString(),
          },
        );

        var data = json.decode(response.body);

        if (response.statusCode == 200 && data['status'] == true) {
          await fetchFavorites(); // إعادة المزامنة الكاملة للتأكيد
          EasyLoading.showSuccess(data['message'] ?? "Added successfully");
        } else {
          // التراجع محلياً في حال فشل السيرفر
          favoriteItems.removeWhere((item) => item.id == product.id);
          product.isFavorite = false;
          update();
          EasyLoading.showError(data['message'] ?? "Failed to add");
        }
      } catch (e) {
        favoriteItems.removeWhere((item) => item.id == product.id);
        product.isFavorite = false;
        update();
        EasyLoading.showError("Connection error");
      }
    }
  }

  /// Legacy function kept for backward compatibility (Optional)
  Future<void> addToFavorites(int? productId) async {
    if (productId == null) return;
    EasyLoading.show(status: 'Adding to wishlist...');
    try {
      final response = await http.post(
        Uri.parse("https://tullana.toldpath.com/api/customer/favorites/add"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {'product_id': productId.toString()},
      );

      var data = json.decode(response.body);
      if (response.statusCode == 200 && data['status'] == true) {
        await fetchFavorites();
        EasyLoading.showSuccess(data['message'] ?? "Added successfully");
      } else {
        EasyLoading.showError(data['message'] ?? "Failed to add");
      }
    } catch (e) {
      EasyLoading.showError("Connection error");
    } finally {
      update();
    }
  }

  /// Legacy function kept for backward compatibility (Optional)
  Future<void> removeFromFavorites(int? productId) async {
    if (productId == null || token == null) return;
    EasyLoading.show(status: 'Removing...');
    try {
      var request = http.Request(
          'DELETE',
          Uri.parse("https://tullana.toldpath.com/api/customer/favorites/remove")
      );
      request.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'package:json',
        'Authorization': 'Bearer $token',
      });
      request.body = json.encode({
        'product_id': [productId],
      });

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        favoriteItems.removeWhere((item) => item.id == productId);
        EasyLoading.showSuccess(data['message'] ?? "Removed successfully");
      } else {
        EasyLoading.showError(data['message'] ?? "Failed to remove");
      }
    } catch (e) {
      EasyLoading.showError("Connection error");
    } finally {
      update();
    }
  }
  Future<void> addAllWishlistToCart(List<dynamic> wishlistItems) async {
    if (wishlistItems.isEmpty) {
      EasyLoading.showInfo("Your wishlist is empty!");
      return;
    }

    try {
      EasyLoading.show(status: 'Adding all items to cart...');

      // 🔄 الدوران على كل المنتجات الموجودة بالمفضلة وإضافتها
      for (var item in wishlistItems) {
        // تأكدي من مسمى الـ id الخاص بالمنتج داخل الـ Model لديكِ (مثلاً item.id أو item.productId)
        final int productId = item.id;

        // استدعاء دالة إضافة منتج منفرد للسلة الموجودة لديكِ مسبقاً
        await Get.find<CartController>().addToCart(quantity: 1 , productId);
      }

      EasyLoading.showSuccess("All items added to cart!");

      // تحديث السلة بعد اكتمال الإضافة الجماعية
      Get.find<CartController>().fetchCart();
    } catch (e) {
      print("Error adding all to cart: $e");
      EasyLoading.showError("Failed to add some items");
    }
  }
}