// import 'package:get/get.dart';
//
// import '../../data/models/api-service.dart';
// import '../../data/models/category_model.dart';
//
// class CategoryController extends GetxController {
//   CategoryModel? categoryModel;
//   bool isLoading = true;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchData();
//   }
//
//   void fetchData() async {
//     isLoading = true;
//     update();
//     // هنا نستدعي الـ ApiService
//     categoryModel = await ApiService.getCategoryProducts();
//     isLoading = false;
//     update();
//   }
// }

import 'package:get/get.dart';
import '../data/models/api-service.dart';

class CategoryController extends GetxController {
  MainCategoryResponse? categoryModel;
  bool isLoading = true;
  String errorMessage = ""; // لإظهار رسالة خطأ للمستخدم إذا فشل الـ API

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading = true;
      errorMessage = "";
      update();

      // استدعاء البيانات
      var result = await ApiService.getCategoryProducts();

      if (result != null) {
        categoryModel = result;
      } else {
        errorMessage = "لا توجد بيانات متاحة حالياً";
      }
    } catch (e) {
      // التعامل مع خطأ 404 أو انقطاع الإنترنت
      errorMessage = "حدث خطأ أثناء جلب البيانات: $e";
      print("Error fetching data: $e");
    } finally {
      isLoading = false;
      update(); // تحديث الواجهة في كل الحالات (نجاح أو فشل)
    }
  }

  // دالة مساعدة للتأكد من الرابط قبل تمريره للـ UI
//   String getSafeImageUrl(int index) {
//     String? url = categoryModel?.data?[index].thumbnail;
//     if (url == null ||
//         url.isEmpty ||
//         url == "null" ||
//         !url.startsWith("http")) {
//       return ""; // إعادة نص فارغ ليتم معالجته في الواجهة
//     }
//     return url;
//   }
//   String getSafeImageUrl(int index) {
//     String? url = categoryModel?.data?[index].thumbnail;
//
//     // إذا كان حقل الـ thumbnail فارغاً، نحاول جلب أول صورة من مصفوفة الـ images
//     if (url == null || url.isEmpty || url == "null") {
//       if (categoryModel?.data?[index].images != null && categoryModel!.data![index].images!.isNotEmpty) {
//         url = categoryModel!.data![index].images![0];
//       }
//     }
//
//     if (url == null || url.isEmpty || url == "null") {
//       return "";
//     }
//
//     // 💡 الحل السحري: إزالة الأقواس المربعة [ ] من البداية والنهاية إن وجدت
//     url = url.replaceAll('[', '').replaceAll(']', '').trim();
//
//     if (!url.startsWith("http")) {
//       return "";
//     }
//
//     return url;
//   }
  // دالة تنظيف روابط الصور من الأقواس المربعة والفراغات
  String getCleanImageUrl(String? url) {
    if (url == null || url.isEmpty || url == "null") return "";
    return url.replaceAll('[', '').replaceAll(']', '').trim();
  }

  // دالة لتنظيف نصوص التفاصيل من وسوم الـ HTML القادمة من السيرفر
  String getCleanDetails(String? htmlText) {
    if (htmlText == null || htmlText.isEmpty) return "No details available.";
    return htmlText.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }
}

class MainCategoryResponse {
  bool? status;

  Category? category;

  List<ProductData>? data;

  Pagination? pagination;

  AppliedFilters? appliedFilters;

  MainCategoryResponse({
    this.status,

    this.category,

    this.data,

    this.pagination,

    this.appliedFilters,
  });

  MainCategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;

    if (json['data'] != null) {
      data = <ProductData>[];

      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
      });
    }

    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;

    appliedFilters = json['applied_filters'] != null
        ? AppliedFilters.fromJson(json['applied_filters'])
        : null;
  }

  Object? operator [](int other) {}
}

class Category {
  int? id;

  String? name;

  String? slug;

  String? image;

  Category({this.id, this.name, this.slug, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'];

    slug = json['slug'];

    image = json['image'];
  }
}
List<ProductData> firstSectionProducts = [];
List<ProductData> secondSectionProducts = [];

class ProductData {
  int? id;

  String? code;

  String? name;

  String? slug;

  String? shortDescription;

  String? details; // هذا هو الحقل الذي تحتاجه للتفاصيل

  String? shop;

  String? unit;

  double? finalUnitPrice;

  String? thumbnail;

  List<String>? images;

  bool? isFavorite;

  ProductData({
    this.id,

    this.code,

    this.name,

    this.slug,

    this.shortDescription,

    this.details,

    this.shop,

    this.finalUnitPrice,

    this.thumbnail,

    this.images,

    this.unit,

    this.isFavorite,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    code = json['code'];

    name = json['name'];

    slug = json['slug'];

    shortDescription = json['short_description'];

    details = json['details']; // تم التأكد من إضافته هنا

    shop = json['shop'];

    unit = json['unit'];

    isFavorite = json['is_favorite'];

    // معالجة السعر لضمان عدم حدوث خطأ double/int

    finalUnitPrice = json['final_unit_price']?.toDouble();

    // حماية ضد خطأ الصورة (null)

    var thumb = json['thumbnail'];

    thumbnail = (thumb == "null" || thumb == null) ? "" : thumb;

    if (json['images'] != null) {
      images = json['images'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;

    data['name'] = name;

    data['details'] = details; // التأكد من وجوده في التخزين أيضاً

    data['short_description'] = shortDescription;

    data['final_unit_price'] = finalUnitPrice;

    data['thumbnail'] = thumbnail;

    data['unit'] = unit;

    data['images'] = images;

    return data;
  }
}

class Pagination {
  int? total;

  int? perPage;

  int? currentPage;

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];

    perPage = json['per_page'];

    currentPage = json['current_page'];
  }
}

class AppliedFilters {
  String? singleCategoryId;

  AppliedFilters.fromJson(Map<String, dynamic> json) {
    singleCategoryId = json['single_category_id'];
  }

  void splitProducts(List<ProductData> allProducts) {
    if (allProducts.length >= 4) {
      // نأخذ أول منتجين للقسم الأول
      firstSectionProducts = allProducts.sublist(0, 2);
      // نأخذ المنتجين الثالث والرابع للقسم الثاني
      secondSectionProducts = allProducts.sublist(2, 4);
    } else {
      // في حال كان العدد أقل من 4، نضع كل المنتجات في القسم الأول
      firstSectionProducts = allProducts;
      secondSectionProducts = [];
    }
  }
}
