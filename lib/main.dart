import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:store_app/core/localization/language_controller.dart';
import 'package:store_app/routes/app_pages.dart';
import 'package:store_app/routes/app_routes.dart';
import 'package:store_app/views/sidebarItems/about_us.dart';
import 'package:store_app/views/sidebarItems/privcy.dart';
import 'package:store_app/views/sidebarItems/support_screen.dart';
import 'package:store_app/views/sidebarItems/terms_screen.dart';
import 'package:store_app/views/store/home_screen.dart';
import 'controllers/address_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/category-controller.dart';
import 'controllers/information_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/whishlist_controller.dart';
import 'core/localization/storaged_services.dart';
import 'core/localization/translation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init());
  Get.put(CategoryController());
   Get.put(InformationController());
  Get.put(FavoriteController(),);
  Get.put(CartController(),);
  Get.put(ProfileController(),);
   Get.put(AddressController());
  Get.lazyPut(()=>LanguageController());
  Get.put(AuthController());
  Firebase.initializeApp();
  var storage = Get.find<StorageService>();
  String? token = Get.find<StorageService>().read('token');
  bool isFirstTime = storage.read('isFirstTime') ?? true;
  String initialRoute;
  if (token != null) {
    initialRoute = AppRoutes.home;
  } else {
    if (isFirstTime) {
      initialRoute = AppRoutes.splash;
    } else {
      initialRoute = AppRoutes.login;
    }
  }
  runApp(MyApp(
      startRoute:initialRoute));
}

class MyApp extends StatelessWidget {
  final String startRoute;
   MyApp({super.key,required this.startRoute,});
  final LanguageController languageController = Get.find<LanguageController>();
  final AuthController authController = Get.find<AuthController>();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414,896),
      child: GetMaterialApp(
        getPages:AppPages.pages,
        // initialRoute:startRoute,
        translations: AppTranslations(),
        locale: languageController.currentLocale.value,
        fallbackLocale:Locale("ar","SA") ,
        debugShowCheckedModeBanner: false,
        home: Home(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

