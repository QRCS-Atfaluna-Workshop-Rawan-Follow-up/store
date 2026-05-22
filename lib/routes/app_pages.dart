import 'package:get/get.dart';
import 'package:store_app/routes/app_routes.dart';
import 'package:store_app/views/Auth/otp.dart';
import 'package:store_app/views/Auth/reset_password.dart';
import 'package:store_app/views/sidebarItems/about_us.dart';
import 'package:store_app/views/sidebarItems/privcy.dart';
import 'package:store_app/views/sidebarItems/terms_screen.dart';
import 'package:store_app/views/store/address_screen.dart';
import '../views/Auth/forget_password.dart';
import '../views/Auth/location_screen.dart';
import '../views/Auth/login_screen.dart';
import '../views/Auth/number_screen.dart';
import '../views/Auth/signup_screen.dart';
import '../views/Auth/singin_screen.dart';
import '../views/Auth/varification_screen.dart';
import '../views/checkout/checkout_dialog.dart';
import '../views/checkout/error_screen.dart';
import '../views/checkout/order_accept_screen.dart';
import '../views/onBoarding/onboarding_screen.dart';
import '../views/onBoarding/splash_screen.dart';
import '../views/sidebarItems/support_screen.dart';
import '../views/store/account_screen.dart';
import '../views/store/all_adresses.dart';
import '../views/store/cart_screen.dart';
import '../views/store/explore_screen.dart';
import '../views/store/favourite_screen.dart';
import '../views/store/filter_screen.dart';
import '../views/store/home_screen.dart';
import '../views/store/product_details.dart';
import '../views/store/search_screen.dart';
import '../views/store/single_category.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.home, page: () => Home()),
    GetPage(name: AppRoutes.account, page: () => Account()),
    GetPage(name: AppRoutes.explore, page: () => Explore()),
    GetPage(name: AppRoutes.favourite, page: () => Favoruite()),
    GetPage(name: AppRoutes.cart, page: () => Cart()),
    GetPage(name: AppRoutes.search, page: () => Search()),
    GetPage(name: AppRoutes.filter, page: () => FilterScreen()),
    GetPage(name: AppRoutes.singleCategory, page: () => SingleCategory()),
    GetPage(name: AppRoutes.productDetails, page: () => ProductDetails()),
    GetPage(name: AppRoutes.resetPassword, page: () => ResetPassword()),
    GetPage(name: AppRoutes.signup, page: () => Signup()),
    GetPage(name: AppRoutes.login, page: () => Login()),
    GetPage(name: AppRoutes.OTP, page: () => OTP()),
    GetPage(name: AppRoutes.forgetPassword, page: () => ForgetPassword()),
    GetPage(name: AppRoutes.varification, page: () => Varification()),
    GetPage(name: AppRoutes.location, page: () => Location()),
    GetPage(name: AppRoutes.addAddress, page: () => AddAddressScreen()),
    GetPage(name: AppRoutes.addressListScreen, page: () => AddressListScreen()),
    GetPage(name: AppRoutes.number, page: () => Number()),
    GetPage(name: AppRoutes.signin, page: () => Signin()),
    GetPage(name: AppRoutes.checkout, page: () => CheckoutDialog()),
    GetPage(name: AppRoutes.orderAccept, page: () => OrderAccept()),
    GetPage(name: AppRoutes.error, page: () => ErrorScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => Onboarding()),
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.aboutUs, page: () => AboutUsScreen()),
    GetPage(name: AppRoutes.terms, page: () => TermsScreen()),
    GetPage(name: AppRoutes.privacy, page: () => Privacy()),
    GetPage(name: AppRoutes.support, page: () => SupportScreen()),
  ];
}
