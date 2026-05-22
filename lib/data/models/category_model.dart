// class MainCategoryResponse {
//   bool? status;
//   Category? category;
//   List<ProductData>? data;
//   Pagination? pagination;
//   AppliedFilters? appliedFilters;
//
//   MainCategoryResponse({
//     this.status,
//     this.category,
//     this.data,
//     this.pagination,
//     this.appliedFilters,
//   });
//
//   MainCategoryResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     category = json['category'] != null ? Category.fromJson(json['category']) : null;
//     if (json['data'] != null) {
//       data = <ProductData>[];
//       json['data'].forEach((v) {
//         data!.add(ProductData.fromJson(v));
//       });
//     }
//     pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
//     appliedFilters = json['applied_filters'] != null ? AppliedFilters.fromJson(json['applied_filters']) : null;
//   }
//
//   Object? operator [](int other) {}
// }
//
// class Category {
//   int? id;
//   String? name;
//   String? slug;
//   String? image;
//
//   Category({this.id, this.name, this.slug, this.image});
//
//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//     image = json['image'];
//   }
// }
//
// // class ProductData {
// //   int? id;
// //   String? name;
// //   String? thumbnail;
// //   List<String>? images;
// //   double? finalUnitPrice;
// //   bool? isFavorite;
// //   // أضفت باقي الحقول الضرورية فقط للاختصار، يمكنك إضافة البقية بنفس النمط
// //
// //   ProductData({this.id, this.name, this.thumbnail, this.images, this.finalUnitPrice, this.isFavorite});
// //
// //   ProductData.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     name = json['name'];
// //     isFavorite = json['is_favorite'];
// //     finalUnitPrice = json['final_unit_price']?.toDouble();
// //
// //     // حماية ضد خطأ file:///null
// //     var thumb = json['thumbnail'];
// //     thumbnail = (thumb == "null" || thumb == null) ? "" : thumb;
// //
// //     if (json['images'] != null) {
// //       images = json['images'].cast<String>();
// //     }
// //   }
// // }
// class ProductData {
//   int? id;
//   String? code;
//   String? name;
//   String? slug;
//   String? shortDescription;
//   String? details; // هذا هو الحقل الذي تحتاجه للتفاصيل
//   String? shop;
//   String? unit;
//   double? finalUnitPrice;
//
//   String? thumbnail;
//   List<String>? images;
//   bool? isFavorite;
//
//   ProductData({
//     this.id,
//     this.code,
//     this.name,
//     this.slug,
//     this.shortDescription,
//     this.details,
//     this.shop,
//     this.finalUnitPrice,
//     this.thumbnail,
//     this.images,
//     this.unit,
//     this.isFavorite,
//
//   });
//
//   ProductData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     code = json['code'];
//     name = json['name'];
//     slug = json['slug'];
//     shortDescription = json['short_description'];
//     details = json['details']; // تم التأكد من إضافته هنا
//     shop = json['shop'];
//     unit = json['unit'];
//     isFavorite = json['is_favorite'];
//
//     // معالجة السعر لضمان عدم حدوث خطأ double/int
//     finalUnitPrice = json['final_unit_price']?.toDouble();
//
//     // حماية ضد خطأ الصورة (null)
//     var thumb = json['thumbnail'];
//     thumbnail = (thumb == "null" || thumb == null) ? "" : thumb;
//
//     if (json['images'] != null) {
//       images = json['images'].cast<String>();
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['details'] = details; // التأكد من وجوده في التخزين أيضاً
//     data['short_description'] = shortDescription;
//     data['final_unit_price'] = finalUnitPrice;
//     data['thumbnail'] = thumbnail;
//     data['unit'] = unit;
//     data['images'] = images;
//     return data;
//   }
// }
// // كلاسات مساعدة معدلة
// class Pagination {
//   int? total;
//   int? perPage;
//   int? currentPage;
//
//   Pagination.fromJson(Map<String, dynamic> json) {
//     total = json['total'];
//     perPage = json['per_page'];
//     currentPage = json['current_page'];
//   }
// }
//
// class AppliedFilters {
//   String? singleCategoryId;
//   AppliedFilters.fromJson(Map<String, dynamic> json) {
//     singleCategoryId = json['single_category_id'];
//   }
// }
class ProductModel {
  int? id;
  String? name;
  String? slug;
  String? shortDescription;
  String? details;
  String? unit;
  double? finalUnitPrice;
  double? originalUnitPrice;
  int? discountPercent;
  int? currentStock;
  String? availabilityInstock;
  String? thumbnail;
  List<String>? images;
  Brand? brand;
  String? currencyCode; // أضفت هذا لجلب العملة من المصفوفة

  ProductModel({
    this.id,
    this.name,
    this.slug,
    this.shortDescription,
    this.details,
    this.unit,
    this.finalUnitPrice,
    this.originalUnitPrice,
    this.discountPercent,
    this.currentStock,
    this.availabilityInstock,
    this.thumbnail,
    this.images,
    this.brand,
    this.currencyCode,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    shortDescription = json['short_description'];
    details = json['details'];
    unit = json['unit'];

    // جلب السعر النهائي والخصم من الحقول المباشرة (أسهل وأسرع)
    finalUnitPrice = (json['final_unit_price'] ?? 0).toDouble();
    originalUnitPrice = (json['original_unit_price'] ?? 0).toDouble();
    discountPercent = json['discount_percent'];

    currentStock = json['current_stock'];
    availabilityInstock = json['availability_instock'];
    thumbnail = json['thumbnail'];

    // معالجة الصور
    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    }

    // معالجة البراند (كائن فرعي)
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;

    // استخراج العملة من أول عنصر في قائمة الأسعار إذا وجدت
    if (json['unit_price'] != null && (json['unit_price'] as List).isNotEmpty) {
      currencyCode = json['unit_price'][0]['currency_code'];
    }
  }
}

class Brand {
  int? id;
  String? name;

  Brand({this.id, this.name});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}