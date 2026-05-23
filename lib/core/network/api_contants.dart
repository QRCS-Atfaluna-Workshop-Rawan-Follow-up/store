class ApiConstants {
   static const String baseUrl = "https://tullana.toldpath.com/api";
   static const String login = '$baseUrl/customer/auth/login';
   static const String signup ='$baseUrl/customer/auth/register';
   static const String forgetPassword ='$baseUrl/auth/forgot-password';
   static const String resetPassword ='$baseUrl/customer/auth/reset-password/';
   static const String varifyOtp ='$baseUrl/customer/auth/verify-otp';
   static const String getCart ='$baseUrl/customer/cart';
   static const String addToCart ='$baseUrl/customer/cart/add';
   static const String updateItemInCart ='$baseUrl/customer/cart/update';
   static const String removeItem ='$baseUrl/customer/cart/remove';
   static const String aboutUs ='$baseUrl/customer/profile/help-center/about-us';
   static const String terms ='$baseUrl/customer/profile/help-center/terms-conditions';
   static const String support ='$baseUrl/customer/technical-support/create';
   static const String privacy ='$baseUrl/customer/profile/help-center/privacy-policy';
   static const String getProductsByCategory ='$baseUrl/customer/categories/products/135';
   static const String getProductsDetails ='$baseUrl/customer/products/details';
   static const String getWishList ='$baseUrl/customer/favorites';
   static const String addToWishList ='$baseUrl/customer/favorites/add';
   static const String removeFromWishList ='$baseUrl/customer/favorites/remove';
   static const String getProfileData ='$baseUrl/customer/profile/info';
   static const String addressList ='$baseUrl/customer/profile/address/list';
   static const String addAddress ='$baseUrl/customer/profile/address/add';
   static const String updateAddress ='$baseUrl/customer/profile/address/update';
   static const String updateProfile ='$baseUrl/customer/profile/update-profile';

}