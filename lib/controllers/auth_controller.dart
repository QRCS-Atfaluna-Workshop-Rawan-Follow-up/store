// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:store_app/routes/app_routes.dart';
//
// import '../../core/localization/storaged_services.dart';
//
// class AuthController extends GetxController {
//   var isLoading = false.obs;
//   final storageService = Get.find<StorageService>();
//   // final storage = GetStorage();
//   // late final String name;
//   // late final String password;
//
//   Future login({required String email, required String password}) async {
//     isLoading.value = true;
//     try {
//       var response = await http.post(
//         Uri.parse("https://tullana.toldpath.com/api/customer/auth/login"),
//         headers: {'Accept': 'application/json'},
//         body: {'email': email, "password": password},
//       );
//       var decodedJson = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         String token = decodedJson['token'];
//         storageService.write('token', token);
//         storageService.write('isLoggedIn', true);
//
//         Get.snackbar("successful", decodedJson['message']);
//         Get.offAllNamed(AppRoutes.home);
//       } else {
//         if (decodedJson['errors'] != null &&
//             decodedJson['errors'] is List &&
//             decodedJson['errors'].isNotEmpty) {
//           String errorMessage = decodedJson['errors'][0]['message'].toString();
//           Get.snackbar("Error", errorMessage);
//         }
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//       print(e);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future signup(
//       {
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String phone,
//     required String password,
//     required String passwordConfirmation,
//   }) async {
//     isLoading.value = true;
//     try {
//       var response = await http.post(
//         Uri.parse("https://tullana.toldpath.com/api/customer/auth/register"),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(
//           {
//             'email': email,
//             "password": password,
//             "last_name": lastName,
//             "first_name": firstName,
//             "phone": phone,
//             "password_confirmation": passwordConfirmation,
//             'country_code': 'PS',
//             'agreed_with_terms': true
//           },
//         )
//       );
//       var decodedJson = jsonDecode(response.body);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         String token = decodedJson['token'];
//         storageService.write('token', token);
//         storageService.write('isLoggedIn', true);
//
//         Get.snackbar("successful", decodedJson['message']);
//         Get.offAllNamed(AppRoutes.home);
//       } else {
//         if (decodedJson['errors'] != null &&
//             decodedJson['errors'] is List &&
//             decodedJson['errors'].isNotEmpty) {
//           String errorMessage = decodedJson['errors'][0]['message'].toString();
//           Get.snackbar("Error", errorMessage);
//         }
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//       print(e);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart'; // تأكدي من استيرادها
import 'package:store_app/routes/app_routes.dart';
import '../core/localization/storaged_services.dart';
import '../views/Auth/reset_password.dart';
import 'otp_model.dart';

class AuthController extends GetxController {
  final storageService = Get.find<StorageService>();

  Future login({required String email, required String password}) async {
    try {
      // 1. إظهار التحميل وقفل الشاشة
      EasyLoading.show(status: 'Now is login in please wait...',
          maskType: EasyLoadingMaskType.custom);

      var response = await http.post(
        Uri.parse("https://tullana.toldpath.com/api/customer/auth/login"),
        headers: {'Accept': 'application/json'},
        body: {'email': email, "password": password},
      );

      var decodedJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String token = decodedJson['token'];
        storageService.write('token', token);
        storageService.write('isLoggedIn', true);
        // 2. إخفاء التحميل وإظهار نجاح
        EasyLoading.showSuccess(decodedJson['message'] ?? "Successful login");

        Get.offAllNamed(AppRoutes.home);
      } else {
        String errorMessage = "error in data";
        if (decodedJson['errors'] != null &&
            (decodedJson['errors'] as List).isNotEmpty) {
          errorMessage = decodedJson['errors'][0]['message'].toString();
        }
        // 3. إظهار الخطأ للمستخدم
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      EasyLoading.showError("حدث خطأ في الاتصال");
      print(e);
    } finally {
      // التأكد من إغلاق التحميل في حال لم يتم إغلاقه
      EasyLoading.dismiss();
    }
  }

  // --- دالة إنشاء حساب جديد ---
  Future signup({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      // 1. إظهار التحميل
      EasyLoading.show(status: 'please wait create account now ..',
          maskType: EasyLoadingMaskType.black);

      var response = await http.post(
          Uri.parse("https://tullana.toldpath.com/api/customer/auth/register"),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': email,
            "password": password,
            "last_name": lastName,
            "first_name": firstName,
            "phone": phone,
            "password_confirmation": passwordConfirmation,
            'country_code': 'PS',
            'agreed_with_terms': true
          }));

      var decodedJson = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        String token = decodedJson['token'];
        storageService.write('token', token);
        storageService.write('isLoggedIn', true);

        EasyLoading.showSuccess(decodedJson['message'] ?? "regiser is done");
        Get.offAllNamed(AppRoutes.home);
      } else {
        String errorMessage = "Faild in create account";
        if (decodedJson['errors'] != null &&
            (decodedJson['errors'] as List).isNotEmpty) {
          errorMessage = decodedJson['errors'][0]['message'].toString();
        }
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      EasyLoading.showError("something error");
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> logout() async {
    try {
      // 1. إظهار تحميل بسيط
      EasyLoading.show(status: 'جاري تسجيل الخروج...');

      // 2. حذف التوكن وحالة تسجيل الدخول من التخزين
      storageService.remove('token');
      storageService.write('isLoggedIn', false);

      // 3. إظهار رسالة نجاح
      EasyLoading.showSuccess('Logout is Success');

      // 4. الانتقال لصفحة تسجيل الدخول وحذف كل الصفحات السابقة من الذاكرة
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      EasyLoading.showError('something make error');
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Future<void> verifyEmail({required String email}) async {
  //   try {
  //     // استدعاء الـ API (تأكدي من تغيير الرابط للرابط الصحيح لديكِ)
  //     var response = await http.post(
  //       Uri.parse(
  //           "https://tullana.toldpath.com/api/customer/auth/forgot-password"),
  //       body: {"email": email},
  //     );
  //
  //     EasyLoading.dismiss();
  //
  //     if (response.statusCode == 200) {
  //       // إذا كان الإيميل موجوداً (السيرفر عادة يرجع 200)
  //       EasyLoading.showSuccess("Email verified. Sending OTP...");
  //       Get.toNamed(AppRoutes.OTP, arguments: email);
  //     } else if (response.statusCode == 404) {
  //       // إذا كان الإيميل غير مسجل
  //       EasyLoading.showError("This email is not registered in our system");
  //     } else {
  //       EasyLoading.showError("Something went wrong, try again");
  //     }
  //   } catch (e) {
  //     EasyLoading.dismiss();
  //     // هنا ضعف النت قد يسبب خطأ، لذا يجب معالجته
  //     EasyLoading.showError("Connection error. Check your internet.");
  //   }
  // }

  // داخل AuthController
  Future<void> sendForgotPasswordEmail(String email) async {
    EasyLoading.show(
        status: 'Sending code...'); // تم تحويلها للإنجليزية كما طلبتِ

    try {
      final response = await http.post(
        Uri.parse("https://tullana.toldpath.com/api/customer/auth/forgot-password"),
        body: {'email': email
        },
      );

      var jsonResponse = json.decode(response.body);

      // استخدام الموديل الجديد
      OtpResponseModel otpRes = OtpResponseModel.fromJson(jsonResponse);

      if (response.statusCode == 200 && otpRes.status == "otp_sent") {
        EasyLoading.showSuccess(otpRes.message ?? "Code sent to your email");

        // الانتقال لشاشة الـ OTP وتمرير البيانات
        Get.toNamed(AppRoutes.OTP, arguments: {
          'email': email,
          'token': otpRes.otp // نمرر الـ OTP للتجربة السريعة (Testing)
        });
      } else {
        EasyLoading.showError("Failed to send code");
      }
    } catch (e) {
      EasyLoading.showError("Connection error");
    } finally {
      EasyLoading.dismiss();
    }
  }
  // Future<void> verifyOtpCode({required String email, required String code}) async {
  //   EasyLoading.show(status: 'Verifying code...');
  //
  //   try {
  //     // بناءً على صورة 5.png الرابط هو verify-otp
  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse("https://tullana.toldpath.com/api/customer/auth/verify-otp"),
  //     );
  //
  //     // إضافة البيانات بنظام form-data كما هو ظاهر في الصورة 5.png
  //     request.fields.addAll({
  //       'email': email,
  //       'token': code, // المفتاح في الصورة هو 'token' والقيمة هي الكود
  //     });
  //
  //     // إرسال الطلب
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     var data = json.decode(response.body);
  //
  //     if (response.statusCode == 200) {
  //       EasyLoading.showSuccess("Code verified successfully!");
  //
  //       // ✅ الانتقال لصفحة تعيين كلمة المرور الجديدة وتمرير الإيميل
  //       Get.offNamed(AppRoutes.resetPassword, arguments: email);
  //     } else {
  //       EasyLoading.showError(data['message'] ?? "Invalid code, please try again");
  //     }
  //   } catch (e) {
  //     print("Verify Error: $e");
  //     EasyLoading.showError("Connection error");
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }
//   Future<void> verifyOtpCode({required String email, required String code}) async {
//     EasyLoading.show(status: 'Verifying code...');
//
//     try {
//       final response = await http.post(
//         // تأكدي من أن الرابط هو verify-code كما في معظم الـ APIs الخاصة بكِ
//         Uri.parse("https://tullana.toldpath.com/api/customer/auth/verify-code"),
//         body: {
//           'email': email,
//           'token': code, // تأكدي هل هو 'code' أم 'token'؟ (الصورة السابقة كانت تقول code)
//         },
//       );
//
//       var data = json.decode(response.body);
//
//       // التحقق من حالة الاستجابة
//       if (response.statusCode == 200 && (data['status'] == true || data['status'] == "success")) {
//         EasyLoading.showSuccess("Code verified successfully!");
//
//         // الانتقال لصفحة كلمة المرور الجديدة
//         // تأكدي أن AppRoutes.resetPassword معرف في ملف الـ Routes
//         Get.offAllNamed(AppRoutes.resetPassword, arguments: email);
//       } else {
//         // إظهار رسالة الخطأ القادمة من السيرفر
//         EasyLoading.showError(data['message'] ?? "Invalid code, please try again");
//       }
//     } catch (e) {
//       print("Verify OTP Error: $e");
//       EasyLoading.showError("Connection error");
//     } finally {
//       EasyLoading.dismiss();
//     }
//   }
  Future<void> verifyOtpCode({required String email, required String code}) async {
    EasyLoading.show(status: 'Verifying code...');

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://tullana.toldpath.com/api/customer/auth/verify-otp"),
      );

      request.fields.addAll({
        'email': email,
        'token': code,
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        EasyLoading.showSuccess("Code verified successfully!");
        Get.offNamed(AppRoutes.resetPassword, arguments: {
          'email': email,
          'token': code, // هكذا سيعرف صفحة التعديل ما هو الكود
        });
        print('TOKEN IS : ${code}');
      } else {
        EasyLoading.showError(data['message'] ?? "Invalid code");
      }
    } catch (e) {
      EasyLoading.showError("Connection error");
    } finally {
      EasyLoading.dismiss();
    }
  }
  Future<void> resetPassword({
    required String email,
    required String otpToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    EasyLoading.show(status: 'Updating password...');

    try {
      final response = await http.put(
        Uri.parse("https://tullana.toldpath.com/api/customer/auth/reset-password"),

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'token': otpToken, // الكود المكون من 4 خانات
          'password': newPassword,
          'confirm_password': confirmPassword, // تأكدي من مطابقة الاسم كما في الصورة 8.png
        }),
      );
      print({
        'email': email,
        'token': otpToken, // الكود المكون من 4 خانات
        'password': newPassword,
        'confirm_password': confirmPassword, // تأكدي من مطابقة الاسم كما في الصورة 8.png
      });

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        EasyLoading.showSuccess(data['message'] ?? "Password reset successfully!");
        Get.offAllNamed(AppRoutes.login);
      } else {
        EasyLoading.showError(data['message'] ?? "Failed to reset password");
      }
    } catch (e) {
      print("Reset Password Error: $e");
      EasyLoading.showError("Connection error");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
