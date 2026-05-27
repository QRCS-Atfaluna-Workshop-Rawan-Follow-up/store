import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../views/no_internet_connection.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  bool _isScreenDisplayed = false; // علم (Flag) لمنع تكرار فتح الشاشة أكثر من مرة

  @override
  void onInit() {
    super.onInit();
    // 📡 بدء الاستماع الفوري والحي لتغيرات الشبكة
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    // التحقق إذا كانت قائمة الاتصالات لا تحتوي على أي شبكة نشطة
    if (connectivityResults.contains(ConnectivityResult.none)) {
      if (!_isScreenDisplayed) {
        _isScreenDisplayed = true;
        _showNoInternetDialog();
      }
    } else {
      // إذا عادت الشبكة وكانت شاشة الحجب مفتوحة، نغلقها تلقائياً فوراُ
      if (_isScreenDisplayed) {
        _isScreenDisplayed = false;
        if (Get.isDialogOpen == true) {
          Get.back(); // إغلاق الدايلوج تلقائياً
          EasyLoading.showSuccess("Back Online!");
        }
      }
    }
  }

  void _showNoInternetDialog() {
    Get.dialog(
      const NoInternetScreen(),
      barrierDismissible: false, // منع الإغلاق عند الضغط على المساحات الفارغة
      useSafeArea: false, // جعل الشاشة تمتد لتغطي شريط الحالة العلوي بالكامل
    );
  }
}