//
// class CartModel {
//   bool? status;
//   List<dynamic>? cart;
//   CartDetails? cartDetails;
//
//   CartModel({this.status, this.cart, this.cartDetails});
//
//   CartModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     cart = json['cart'];
//     cartDetails = json['cart_details'] != null
//         ? CartDetails.fromJson(json['cart_details'])
//         : null;
//   }
// }
// class CartDetails {
//   double? totalCost;
//   // أضيفي باقي الحقول هنا (tax, delivery_fee...)
//
//   CartDetails({this.totalCost});
//
//   CartDetails.fromJson(Map<String, dynamic> json) {
//     totalCost = double.tryParse(json['total_cost'].toString());
//   }
// }

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../core/localization/storaged_services.dart';
import '../data/models/cart_model.dart';

class CartController extends GetxController {
  // متغير لتخزين بيانات السلة بالكامل
  CartResponse? cartData;

  // قائمة المنتجات فقط ليسهل الوصول إليها في ListView
  List<CartItem> cartItems = [];

  // التوكن الخاص بالمستخدم
  String? get token => Get.find<StorageService>().read('token');

  // Future<void> fetchCart() async {
  //   // إذا لم يكن هناك توكن، لا داعي لطلب البيانات
  //   if (token == null) return;
  //
  //   EasyLoading.show(status: 'جاري تحميل السلة...');
  //
  //   try {
  //     var response = await http.get(
  //       Uri.parse("https://tullana.toldpath.com/api/customer/cart"),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.decode(response.body);
  //
  //       if (jsonResponse['status'] == true) {
  //         // تحويل الـ JSON إلى كائن من نوع CartResponse
  //         cartData = CartResponse.fromJson(jsonResponse);
  //
  //
  //         // تحديث قائمة المنتجات
  //         cartItems = cartData?.cart ?? [];
  //
  //         print("تم جلب السلة بنجاح: ${cartItems.length} منتج");
  //       }
  //     } else {
  //       print("خطأ في السيرفر: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error Fetching Cart: $e");
  //     EasyLoading.showError("فشل في تحميل السلة");
  //   } finally {
  //     update(); // تحديث GetBuilder في الواجهة
  //     EasyLoading.dismiss();
  //   }
  // }
  Future<void> fetchCart() async {
    if (token == null) return;
    EasyLoading.show(status: 'Updating...');
    try {
      var response = await http.get(
        Uri.parse("https://tullana.toldpath.com/api/customer/cart"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          cartData = CartResponse.fromJson(jsonResponse);

          // ✅ الحل هنا: نقوم بتفريغ القائمة وإعادة تعبئتها بدلاً من مساواتها مباشرة
          cartItems.clear();
          if (cartData?.cart != null) {
            cartItems.addAll(cartData!.cart!);
          }

          print("Cart Updated: ${cartItems.length} items");
        }
      }
    } catch (e) {
      print("Error Fetching Cart: $e");
    } finally {
      update(); // تأكدي أن هذا السطر يتم تنفيذه دائماً
      EasyLoading.dismiss();
    }
  }
  Future<void> addToCart(int? productId, {int quantity = 1}) async {
    if (productId == null) return;

    EasyLoading.show(status: 'Adding to cart...');

    try {
      final response = await http.post(
        Uri.parse("https://tullana.toldpath.com/api/customer/cart/add"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'product_id': productId.toString(),
          'quantity': quantity.toString(),
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        EasyLoading.showSuccess(data['message'] ?? "Added Successfully!");

        // Refresh the cart data to show updated prices and items
        await fetchCart();
      } else {
        EasyLoading.showError(data['message'] ?? "Failed to add");
      }
    } catch (e) {
      print("Add to Cart Error: $e");
      EasyLoading.showError("Connection Error");
    } finally {
      update();
    }
  }
  Future<void> updateCartQuantity(int? cartId, int newQuantity) async {
    if (cartId == null || newQuantity < 1) return;
    EasyLoading.show(status: 'Updating...');
    try {
      final response = await http.put(
        Uri.parse("https://tullana.toldpath.com/api/customer/cart/update"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'key': cartId.toString(), // The ID of the item in the cart
          'quantity': newQuantity.toString(),
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        // Refresh cart to get new totals and prices
        await fetchCart();
        EasyLoading.dismiss();
        // 2. CRITICAL: Manually trigger the UI rebuild
        update();


      } else {
        EasyLoading.showError(data['message'] ?? "Update failed");
      }
    } catch (e) {
      print("Update Cart Error: $e");
      EasyLoading.showError("Connection Error");
    } finally {
      update();
    }
  }
  void incrementQuantity(CartItem item) {
    int newQty = (item.quantity ?? 1) + 1;
    updateCartQuantity(item.id, newQty);
    fetchCart();
  }

  void decrementQuantity(CartItem item) {
    if ((item.quantity ?? 1) > 1) {
      int newQty = (item.quantity ?? 1) - 1;
      updateCartQuantity(item.id, newQty);
      fetchCart();
    } else {
      EasyLoading.showInfo("Minimum quantity is 1");

    }
  }

  Future<void> deleteFromCart(int? cartId) async {
    if (cartId == null) return;

    EasyLoading.show(status: 'Removing item...');

    try {
      final response = await http.delete(
        Uri.parse("https://tullana.toldpath.com/api/customer/cart/remove"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'key': cartId.toString(),
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        // 1. Refresh the local list immediately from the server
        await fetchCart();

        // 2. Notify the UI
        update();

        EasyLoading.showSuccess(data['message'] ?? "Deleted Successfully");
      } else {
        EasyLoading.showError(data['message'] ?? "Failed to delete");
      }
    } catch (e) {
      print("Delete Error: $e");
      EasyLoading.showError("Connection Error");
    } finally {
      update();
    }
  }










  // دالة مساعدة لحساب عدد المنتجات الكلي في السلة
  int get totalItemsCount => cartItems.length;

  // دالة مساعدة للحصول على السعر الإجمالي النهائي من السيرفر
  dynamic get finalTotalCost => cartData?.cartDetails?.totalCost ?? 0;
}