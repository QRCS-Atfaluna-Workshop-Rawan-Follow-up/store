import 'dart:convert';
class CartResponse {
  bool? status;
  List<CartItem>? cart;
  CartSummary? cartDetails;
  dynamic appliedCoupon;

  CartResponse({
    this.status,
    this.cart,
    this.cartDetails,
    this.appliedCoupon,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      status: json['status'],
      cart: json['cart'] != null
          ? (json['cart'] as List).map((v) => CartItem.fromJson(v)).toList()
          : [],
      cartDetails: json['cart_details'] != null
          ? CartSummary.fromJson(json['cart_details'])
          : null,
      appliedCoupon: json['applied_coupon'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (cart != null) {
      data['cart'] = cart!.map((v) => v.toJson()).toList();
    }
    if (cartDetails != null) {
      data['cart_details'] = cartDetails!.toJson();
    }
    data['applied_coupon'] = appliedCoupon;
    return data;
  }
}

class CartItem {
  int? id;
  String? cartGroupId;
  String? customerId;
  String? productId;
  int? quantity;
  dynamic price;
  dynamic originalPrice;
  dynamic discountedPrice;
  dynamic tax;
  dynamic discount;
  dynamic discountPercent;
  String? thumbnail;
  String? shopInfo;
  CartProduct? product;

  CartItem({
    this.id,
    this.cartGroupId,
    this.customerId,
    this.productId,
    this.quantity,
    this.price,
    this.originalPrice,
    this.discountedPrice,
    this.tax,
    this.discount,
    this.discountPercent,
    this.thumbnail,
    this.shopInfo,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      cartGroupId: json['cart_group_id'],
      customerId: json['customer_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price: json['price'],
      originalPrice: json['original_price'],
      discountedPrice: json['discounted_price'],
      tax: json['tax'],
      discount: json['discount'],
      discountPercent: json['discount_percent'],
      thumbnail: json['thumbnail'],
      shopInfo: json['shop_info'],
      product: json['product'] != null ? CartProduct.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cart_group_id'] = cartGroupId;
    data['customer_id'] = customerId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['original_price'] = originalPrice;
    data['discounted_price'] = discountedPrice;
    data['tax'] = tax;
    data['discount'] = discount;
    data['discount_percent'] = discountPercent;
    data['thumbnail'] = thumbnail;
    data['shop_info'] = shopInfo;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class CartProduct {
  int? id;
  String? name;
  String? thumbnail;
  String? unit;
  dynamic unitPrice;
  dynamic discount;
  String? discountType;
  String? categoryName;

  CartProduct({
    this.id,
    this.name,
    this.thumbnail,
    this.unit,
    this.unitPrice,
    this.discount,
    this.discountType,
    this.categoryName,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      name: json['name'],
      thumbnail: json['thumbnail'],
      unit: json['unit'],
      unitPrice: json['unit_price'],
      discount: json['discount'],
      discountType: json['discount_type'],
      categoryName: json['category_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['unit'] = unit;
    data['unit_price'] = unitPrice;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['category_name'] = categoryName;
    return data;
  }
}

class CartSummary {
  dynamic subTotal;
  dynamic tax;
  dynamic deliveryFee;
  dynamic productDiscount;
  dynamic totalDiscount;
  dynamic totalCost;

  CartSummary({
    this.subTotal,
    this.tax,
    this.deliveryFee,
    this.productDiscount,
    this.totalDiscount,
    this.totalCost,
  });

  factory CartSummary.fromJson(Map<String, dynamic> json) {
    return CartSummary(
      subTotal: json['sub_total'],
      tax: json['tax'],
      deliveryFee: json['delivery_fee'],
      productDiscount: json['product_discount'],
      totalDiscount: json['total_discount'],
      totalCost: json['total_cost'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_total'] = subTotal;
    data['tax'] = tax;
    data['delivery_fee'] = deliveryFee;
    data['product_discount'] = productDiscount;
    data['total_discount'] = totalDiscount;
    data['total_cost'] = totalCost;
    return data;
  }
}