
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart'; // تأكدي من استيرادها
import 'package:store_app/core/network/api_contants.dart';
import 'package:store_app/routes/app_routes.dart';
import '../core/localization/storaged_services.dart';
import 'otp_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthController extends GetxController {
  final storageService = Get.find<StorageService>();

  Future login({required String email, required String password}) async {
    try {
      EasyLoading.show(status: 'Now is login in please wait...',
        maskType: EasyLoadingMaskType.black,);

      var response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {'Accept': 'application/json'},
        body: {'email': email, "password": password},
      );

      var decodedJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String token = decodedJson['token'];
        storageService.write('token', token);
        storageService.write('isLoggedIn', true);
        EasyLoading.showSuccess(decodedJson['message'] ?? "Successful login");

        Get.offAllNamed(AppRoutes.home);
      } else {
        String errorMessage = "error in data";
        if (decodedJson['errors'] != null &&
            (decodedJson['errors'] as List).isNotEmpty) {
          errorMessage = decodedJson['errors'][0]['message'].toString();
        }
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      EasyLoading.showError("حدث خطأ في الاتصال");
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }
  Future signup({required String firstName, required String lastName, required String email,
    required String phone, required String password, required String passwordConfirmation,
  }) async
  {
    try {
      EasyLoading.show(status: 'please wait create account now ..',
          maskType: EasyLoadingMaskType.black);

      var response = await http.post(
          Uri.parse(ApiConstants.signup),
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
      EasyLoading.show(status: 'جاري تسجيل الخروج...');

      storageService.remove('token');
      storageService.write('isLoggedIn', false);
      EasyLoading.showSuccess('Logout is Success');
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      EasyLoading.showError('something make error');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> sendForgotPasswordEmail(String email) async {
    EasyLoading.show(
        status: 'Sending code...');
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.forgetPassword),
        body: {'email': email
        },
      );

      var jsonResponse = json.decode(response.body);
      OtpResponseModel otpRes = OtpResponseModel.fromJson(jsonResponse);

      if (response.statusCode == 200 && otpRes.status == "otp_sent") {
        EasyLoading.showSuccess(otpRes.message ?? "Code sent to your email");

        Get.toNamed(AppRoutes.OTP, arguments: {
          'email': email,
          'token': otpRes.otp
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
  Future<void> verifyOtpCode({required String email, required String code}) async {
    EasyLoading.show(status: 'Verifying code...');
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstants.varifyOtp),
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
          'token': code,
        });
        // print('TOKEN IS : ${code}');
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
  }) async
  {
    EasyLoading.show(status: 'Updating password...');

    try {
      final response = await http.put(
        Uri.parse(ApiConstants.resetPassword),

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'token': otpToken,
          'password': newPassword,
          'confirm_password': confirmPassword,
        }),
      );
      // print({
      //   'email': email,
      //   'token': otpToken,
      //   'password': newPassword,
      //   'confirm_password': confirmPassword,
      // });
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
  // متغيرات خاصة بـ Firebase Auth
  String _verificationId = "";

// دالة إرسال الكود
  Future<void> sendOtpToPhone(String phone) async {
    try {
      EasyLoading.show(status: 'Sending code...'); // تشغيل اللودينج

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          EasyLoading.showError("Failed to send code");
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          storageService.write('temp_phone', phone);
          EasyLoading.showSuccess("Code sent successfully");
          Get.toNamed(AppRoutes.varification); // الانتقال لصفحة الكود
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      EasyLoading.showError("Failed to send code");
    }
  }
  // 2. دالة التحقق من الكود ثم استدعاء الـ API الخاص بكِ
  Future<void> verifyOtpAndSubmit(String smsCode, Map<String, dynamic> userData) async {
    try {
      EasyLoading.show(status: 'Verifying code...');

      // 1. التحقق من الكود عبر Firebase
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      // تسجيل الدخول في Firebase للتأكد من صحة الكود
      await FirebaseAuth.instance.signInWithCredential(credential);

      // 2. إذا نجح Firebase، نقوم بإنشاء الحساب في السيرفر الخاص بك
      // نستخدم await للتأكد من انتهاء عملية التسجيل قبل الانتقال
      await signup(
        firstName: userData['first_name'] ?? "",
        lastName: userData['last_name'] ?? "",
        email: userData['email'] ?? "",
        phone: storageService.read('temp_phone') ?? "",
        password: userData['password'] ?? "",
        passwordConfirmation: userData['password_confirmation'] ?? "",
      );

      // 3. الانتقال لصفحة الموقع بعد نجاح التسجيل
      // استخدمنا offAllNamed لضمان عدم العودة لصفحة التحقق مرة أخرى
      Get.offAllNamed(AppRoutes.location);

      EasyLoading.showSuccess("Registration Successful!");

    } catch (e) {
      // طباعة الخطأ في الـ Console لمعرفة السبب الحقيقي لو فشل
      print("Verification Error: $e");
      EasyLoading.showError("Invalid OTP code or Server Error");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
