import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_app/core/network/api_contants.dart';

import '../../controllers/category-controller.dart';


class ApiService {
  // static const String baseUrl =
  // "https://tullana.toldpath.com/api/customer/categories"; // استبدله برابط الـ API الخاص بك

  static Future<MainCategoryResponse?> getCategoryProducts() async {
    try {
      final response = await
      http.get(
          Uri.parse(ApiConstants.getProductsByCategory));

      if (response.statusCode == 200) {
        // تحويل نص الـ JSON إلى Map ثم إلى Model
        Map<String, dynamic> data = jsonDecode(response.body);
        // print(data);
        return MainCategoryResponse.fromJson(data);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  Future login()async{
    final String  url= 'https://tullana.toldpath.com/api/customer/auth/login';
    var respons = await http.post(Uri.parse(url),
    body:{
        'email':"m@m.com",
        "password":'123123123'
        });

    print(respons.body);
  }

}