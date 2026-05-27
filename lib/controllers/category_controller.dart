import 'package:get/get.dart';
import '../data/models/api-service.dart';
import '../data/models/category_model.dart';

class CategoryController extends GetxController {
  MainCategoryResponse? categoryModel;
  bool isLoading = true;
  String errorMessage = "";

  // 🎯 القوائم المخصصة لعرض المنتجات في الأقسام المختلفة داخل الـ UI
  List<ProductData> firstSectionProducts = [];
  List<ProductData> secondSectionProducts = [];
  List<ProductData> thirdSectionProducts = [];

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading = true;
      errorMessage = "";
      firstSectionProducts.clear();
      secondSectionProducts.clear();
      thirdSectionProducts.clear();
      update();

      var result = await ApiService.getCategoryProducts();

      if (result != null) {
        categoryModel = result;
        splitProductsDynamically();
      } else {
        errorMessage = "لا توجد بيانات متاحة حالياً";
      }
    } catch (e) {
      errorMessage = "حدث خطأ أثناء جلب البيانات: $e";
      print("Error fetching data: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  void splitProductsDynamically() {
    if (categoryModel != null && categoryModel!.data != null && categoryModel!.data!.isNotEmpty) {

      List<ProductData> allProducts = categoryModel!.data!;
      if (allProducts.length >= 6) {
        firstSectionProducts = allProducts.sublist(0, 2);
        secondSectionProducts = allProducts.sublist(2, 4);
        thirdSectionProducts = allProducts.sublist(4, 6);
      } else if (allProducts.length >= 4) {
        firstSectionProducts = allProducts.sublist(0, 2);
        secondSectionProducts = allProducts.sublist(2, 4);
        thirdSectionProducts = [];
      }
        else if (allProducts.length >= 2) {
        firstSectionProducts = allProducts.sublist(0, 1);
        secondSectionProducts = allProducts.sublist(1);
        thirdSectionProducts = [];
      } else {
        firstSectionProducts = allProducts;
        secondSectionProducts = [];
        thirdSectionProducts = [];
      }
    }
  }
  String getCleanImageUrl(String? url) {
    if (url == null || url.isEmpty || url == "null") return "";
    return url.replaceAll('[', '').replaceAll(']', '').trim();
  }

  String getCleanDetails(String? htmlText) {
    if (htmlText == null || htmlText.isEmpty) return "No details available.";
    return htmlText.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }
}