// class FavoriteResponse {
//   bool? status;
//   List<FavoriteProduct>? data;
//
//   FavoriteResponse({this.status, this.data});
//
//   FavoriteResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <FavoriteProduct>[];
//       json['data'].forEach((v) {
//         data!.add(FavoriteProduct.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class FavoriteProduct {
//   int? id;
//   String? code;
//   String? name;
//   String? slug;
//   String? shortDescription;
//   String? details;
//   String? shop;
//   Brand? brand;
//   String? unit;
//   int? minQty;
//   List<UnitPrice>? unitPrice;
//   dynamic purchasePrice;
//   int? discount;
//   String? discountType;
//   int? discountPercent;
//   dynamic originalUnitPrice;
//   dynamic discountedUnitPrice;
//   int? currentStock;
//   int? totalStock;
//   String? availabilityInstock;
//   dynamic lowStockWarning;
//   String? minimumOrderQty;
//   dynamic finalUnitPrice;
//   int? rating;
//   bool? isFavorite;
//   String? thumbnail;
//   MainCategory? mainCategory;
//   List<String>? images;
//   List<UnitPrice>? gulfPrices;
//   List<dynamic>? colors;
//   List<String>? sizes;
//   List<int>? attributes;
//   List<ChoiceOptions>? choiceOptions;
//   List<Variations>? variations;
//   bool? hasVariations;
//   List<SizeOptions>? sizeOptions;
//
//   FavoriteProduct({
//     this.id, this.code, this.name, this.slug, this.shortDescription,
//     this.details, this.shop, this.brand, this.unit, this.minQty,
//     this.unitPrice, this.purchasePrice, this.discount, this.discountType,
//     this.discountPercent, this.originalUnitPrice, this.discountedUnitPrice,
//     this.currentStock, this.totalStock, this.availabilityInstock,
//     this.lowStockWarning, this.minimumOrderQty, this.finalUnitPrice,
//     this.rating, this.isFavorite, this.thumbnail, this.mainCategory,
//     this.images, this.gulfPrices, this.colors, this.sizes, this.attributes,
//     this.choiceOptions, this.variations, this.hasVariations, this.sizeOptions,
//   });
//
//   FavoriteProduct.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     code = json['code'];
//     name = json['name'];
//     slug = json['slug'];
//     shortDescription = json['short_description'];
//     details = json['details'];
//     shop = json['shop'];
//     brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
//     unit = json['unit'];
//     minQty = json['min_qty'];
//     if (json['unit_price'] != null) {
//       unitPrice = <UnitPrice>[];
//       json['unit_price'].forEach((v) => unitPrice!.add(UnitPrice.fromJson(v)));
//     }
//     purchasePrice = json['purchase_price'];
//     discount = json['discount'];
//     discountType = json['discount_type'];
//     discountPercent = json['discount_percent'];
//     originalUnitPrice = json['original_unit_price'];
//     discountedUnitPrice = json['discounted_unit_price'];
//     currentStock = json['current_stock'];
//     totalStock = json['total_stock'];
//     availabilityInstock = json['availability_instock'];
//     lowStockWarning = json['low_stock_warning'];
//     minimumOrderQty = json['minimum_order_qty'];
//     finalUnitPrice = json['final_unit_price'];
//     rating = json['rating'];
//     isFavorite = json['is_favorite'];
//     thumbnail = json['thumbnail'];
//     mainCategory = json['main_category'] != null ? MainCategory.fromJson(json['main_category']) : null;
//     images = json['images']?.cast<String>();
//     if (json['gulf_prices'] != null) {
//       gulfPrices = <UnitPrice>[];
//       json['gulf_prices'].forEach((v) => gulfPrices!.add(UnitPrice.fromJson(v)));
//     }
//     colors = json['colors'];
//     sizes = json['sizes']?.cast<String>();
//     attributes = json['attributes']?.cast<int>();
//     if (json['choice_options'] != null) {
//       choiceOptions = <ChoiceOptions>[];
//       json['choice_options'].forEach((v) => choiceOptions!.add(ChoiceOptions.fromJson(v)));
//     }
//     if (json['variations'] != null) {
//       variations = <Variations>[];
//       json['variations'].forEach((v) => variations!.add(Variations.fromJson(v)));
//     }
//     hasVariations = json['has_variations'];
//     if (json['size_options'] != null) {
//       sizeOptions = <SizeOptions>[];
//       json['size_options'].forEach((v) => sizeOptions!.add(SizeOptions.fromJson(v)));
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['final_unit_price'] = finalUnitPrice;
//     data['thumbnail'] = thumbnail;
//     if (brand != null) data['brand'] = brand!.toJson();
//     if (mainCategory != null) data['main_category'] = mainCategory!.toJson();
//     if (unitPrice != null) data['unit_price'] = unitPrice!.map((v) => v.toJson()).toList();
//     return data;
//   }
// }
//
// class UnitPrice {
//   String? countryName;
//   String? currencyCode;
//   dynamic price;
//   String? formattedPrice;
//
//   UnitPrice({this.countryName, this.currencyCode, this.price, this.formattedPrice});
//
//   UnitPrice.fromJson(Map<String, dynamic> json) {
//     countryName = json['country_name'];
//     currencyCode = json['currency_code'];
//     price = json['price'];
//     formattedPrice = json['formatted_price'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['country_name'] = countryName;
//     data['price'] = price;
//     data['formatted_price'] = formattedPrice;
//     return data;
//   }
// }
//
// class Brand {
//   int? id;
//   String? name;
//
//   Brand({this.id, this.name});
//
//   Brand.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'id': id, 'name': name};
//   }
// }
//
// class MainCategory {
//   int? id;
//   String? name;
//   String? slug;
//
//   MainCategory({this.id, this.name, this.slug});
//
//   MainCategory.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'id': id, 'name': name, 'slug': slug};
//   }
// }
//
// class ChoiceOptions {
//   int? id;
//   String? name;
//   List<String>? options;
//
//   ChoiceOptions({this.id, this.name, this.options});
//
//   ChoiceOptions.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     options = json['options']?.cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'id': id, 'name': name, 'options': options};
//   }
// }
//
// class Variations {
//   String? type;
//   dynamic price;
//   String? sku;
//   String? qty;
//
//   Variations({this.type, this.price, this.sku, this.qty});
//
//   Variations.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     price = json['price'];
//     sku = json['sku'];
//     qty = json['qty'];
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'type': type, 'price': price, 'sku': sku, 'qty': qty};
//   }
// }
//
// class SizeOptions {
//   String? code;
//   String? name;
//   String? variantValue;
//
//   SizeOptions({this.code, this.name, this.variantValue});
//
//   SizeOptions.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     name = json['name'];
//     variantValue = json['variant_value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'code': code, 'name': name, 'variant_value': variantValue};
//   }
// }
class FavoriteResponse {
  bool? status;
  List<FavoriteProduct>? data;

  FavoriteResponse({this.status, this.data});

  FavoriteResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <FavoriteProduct>[];
      json['data'].forEach((v) {
        data!.add(FavoriteProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteProduct {
  int? id;
  String? code;
  String? name;
  String? slug;
  String? shortDescription;
  String? details;
  String? shop;
  Brand? brand;
  String? unit;
  int? minQty;
  List<UnitPrice>? unitPrice;
  dynamic purchasePrice;
  double? discount; // 💡 تم التعديل إلى double لتجنب كراش الأرقام العشرية
  String? discountType;
  double? discountPercent; // 💡 تم التعديل إلى double
  dynamic originalUnitPrice;
  dynamic discountedUnitPrice;
  int? currentStock;
  int? totalStock;
  String? availabilityInstock;
  dynamic lowStockWarning;
  String? minimumOrderQty;
  double? finalUnitPrice; // 💡 تم التعديل إلى double ليتوافق مع ProductData
  int? rating;
  bool? isFavorite;
  String? thumbnail;
  MainCategory? mainCategory;
  List<String>? images;
  List<UnitPrice>? gulfPrices;
  List<dynamic>? colors;
  List<String>? sizes;
  List<int>? attributes;
  List<ChoiceOptions>? choiceOptions;
  List<Variations>? variations;
  bool? hasVariations;
  List<SizeOptions>? sizeOptions;

  FavoriteProduct({
    this.id, this.code, this.name, this.slug, this.shortDescription,
    this.details, this.shop, this.brand, this.unit, this.minQty,
    this.unitPrice, this.purchasePrice, this.discount, this.discountType,
    this.discountPercent, this.originalUnitPrice, this.discountedUnitPrice,
    this.currentStock, this.totalStock, this.availabilityInstock,
    this.lowStockWarning, this.minimumOrderQty, this.finalUnitPrice,
    this.rating, this.isFavorite, this.thumbnail, this.mainCategory,
    this.images, this.gulfPrices, this.colors, this.sizes, this.attributes,
    this.choiceOptions, this.variations, this.hasVariations, this.sizeOptions,
  });

  FavoriteProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    slug = json['slug'];
    shortDescription = json['short_description'];
    details = json['details'];
    shop = json['shop'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    unit = json['unit'];
    minQty = json['min_qty'];
    if (json['unit_price'] != null) {
      unitPrice = <UnitPrice>[];
      json['unit_price'].forEach((v) => unitPrice!.add(UnitPrice.fromJson(v)));
    }
    purchasePrice = json['purchase_price'];

    // 💡 الحماية السحرية لقيم الديسكاونت والأسعار لتحويلها دائماً لـ double بأمان
    discount = json['discount']?.toDouble();
    discountType = json['discount_type'];
    discountPercent = json['discount_percent']?.toDouble();

    originalUnitPrice = json['original_unit_price'];
    discountedUnitPrice = json['discounted_unit_price'];
    currentStock = json['current_stock'];
    totalStock = json['total_stock'];
    availabilityInstock = json['availability_instock'];
    lowStockWarning = json['low_stock_warning'];
    minimumOrderQty = json['minimum_order_qty'];

    // 💡 تحويل السعر النهائي لـ double ليتطابق مع ما يستقبله الـ UI والـ ProductData
    finalUnitPrice = json['final_unit_price']?.toDouble();

    rating = json['rating'];
    isFavorite = json['is_favorite'];
    thumbnail = json['thumbnail'];
    mainCategory = json['main_category'] != null ? MainCategory.fromJson(json['main_category']) : null;
    images = json['images']?.cast<String>();
    if (json['gulf_prices'] != null) {
      gulfPrices = <UnitPrice>[];
      json['gulf_prices'].forEach((v) => gulfPrices!.add(UnitPrice.fromJson(v)));
    }
    colors = json['colors'];
    sizes = json['sizes']?.cast<String>();
    attributes = json['attributes']?.cast<int>();
    if (json['choice_options'] != null) {
      choiceOptions = <ChoiceOptions>[];
      json['choice_options'].forEach((v) => choiceOptions!.add(ChoiceOptions.fromJson(v)));
    }
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) => variations!.add(Variations.fromJson(v)));
    }
    hasVariations = json['has_variations'];
    if (json['size_options'] != null) {
      sizeOptions = <SizeOptions>[];
      json['size_options'].forEach((v) => sizeOptions!.add(SizeOptions.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['final_unit_price'] = finalUnitPrice;
    data['thumbnail'] = thumbnail;
    if (brand != null) data['brand'] = brand!.toJson();
    if (mainCategory != null) data['main_category'] = mainCategory!.toJson();
    if (unitPrice != null) data['unit_price'] = unitPrice!.map((v) => v.toJson()).toList();
    return data;
  }
}

class UnitPrice {
  String? countryName;
  String? currencyCode;
  double? price; // 💡 تعديل إلى double لحماية أسعار العملات الأخرى
  String? formattedPrice;

  UnitPrice({this.countryName, this.currencyCode, this.price, this.formattedPrice});

  UnitPrice.fromJson(Map<String, dynamic> json) {
    countryName = json['country_name'];
    currencyCode = json['currency_code'];
    price = json['price']?.toDouble(); // 💡 حماية الـ double
    formattedPrice = json['formatted_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_name'] = countryName;
    data['price'] = price;
    data['formatted_price'] = formattedPrice;
    return data;
  }
}

// باقي الكلاسات المساعدة (Brand, MainCategory...) تظل كما هي بدون تعديل لأنها تستقبل نصوص أو IDs صحيحة دائماً
class Brand {
  int? id;
  String? name;
  Brand({this.id, this.name});
  Brand.fromJson(Map<String, dynamic> json) { id = json['id']; name = json['name']; }
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
class MainCategory {
  int? id; String? name; String? slug;
  MainCategory({this.id, this.name, this.slug});
  MainCategory.fromJson(Map<String, dynamic> json) { id = json['id']; name = json['name']; slug = json['slug']; }
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'slug': slug};
}
class ChoiceOptions {
  int? id; String? name; List<String>? options;
  ChoiceOptions({this.id, this.name, this.options});
  ChoiceOptions.fromJson(Map<String, dynamic> json) { id = json['id']; name = json['name']; options = json['options']?.cast<String>(); }
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'options': options};
}
class Variations {
  String? type; dynamic price; String? sku; String? qty;
  Variations({this.type, this.price, this.sku, this.qty});
  Variations.fromJson(Map<String, dynamic> json) { type = json['type']; price = json['price']; sku = json['sku']; qty = json['qty']; }
  Map<String, dynamic> toJson() => {'type': type, 'price': price, 'sku': sku, 'qty': qty};
}
class SizeOptions {
  String? code; String? name; String? variantValue;
  SizeOptions({this.code, this.name, this.variantValue});
  SizeOptions.fromJson(Map<String, dynamic> json) { code = json['code']; name = json['name']; variantValue = json['variant_value']; }
  Map<String, dynamic> toJson() => {'code': code, 'name': name, 'variant_value': variantValue};
}