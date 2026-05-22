// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../controllers/profile_controller.dart';
// import '../../core/localization/storaged_services.dart';
// import '../widgets/store_text.dart';
//
// class AccountDetailsScreen extends StatefulWidget {
//   final ProfileController controller;
//
//   const AccountDetailsScreen({super.key, required this.controller});
//
//   @override
//   State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
// }
//
// class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
//   // تعريف المتحكمات لجميع الحقول المطلوبة بما فيها الدولة والمدينة
//   late TextEditingController fNameController;
//   late TextEditingController lNameController;
//   late TextEditingController emailController;
//   late TextEditingController phoneController;
//   late TextEditingController countryController;
//   late TextEditingController cityController;
//
//   final storageService = Get.find<StorageService>();
//
//   @override
//   void initState() {
//     super.initState();
//
//     // تهيئة الحقول من بيانات الكنترولر الحالي
//     fNameController = TextEditingController(text: widget.controller.currentUser?.firstName);
//     lNameController = TextEditingController(text: widget.controller.currentUser?.lastName);
//     emailController = TextEditingController(text: widget.controller.currentUser?.email);
//     phoneController = TextEditingController(text: widget.controller.currentUser?.phone);
//
//     // سحب بيانات الدولة والمدينة المخزنة داخل الـ Local Storage تلقائياً عند ولادة الشاشة
//     // استبدلي المسميات ('country', 'city') حسب مفاتيح التخزين المعتمدة في تطبيقكِ
//     countryController = TextEditingController(text: storageService.read('zone') ?? '');
//     cityController = TextEditingController(text: storageService.read('area') ?? '');
//   }
//
//   @override
//   void dispose() {
//     // تنظيف جميع الـ Controllers من الذاكرة لضمان عدم تسريب البيانات
//     fNameController.dispose();
//     lNameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     countryController.dispose();
//     cityController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffffffff),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffffffff),
//         elevation: 0,
//         centerTitle: true,
//         leading: InkWell(
//           onTap: () => Get.back(),
//           child: const Icon(Icons.arrow_back_ios, color: Colors.black),
//         ),
//         title: StoreText(
//           value: "Account Details",
//           fontSize: 20.sp,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               StoreText(
//                 value: "Profile Information",
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xff7C7C7C),
//               ),
//               SizedBox(height: 20.h),
//
//               // حقول الاسم الأول والأخير والبريد والجوال
//               _buildModernField(fNameController, "First Name", Icons.person_outline),
//               SizedBox(height: 15.h),
//               _buildModernField(lNameController, "Last Name", Icons.person_outline),
//               SizedBox(height: 15.h),
//               _buildModernField(emailController, "Email Address", Icons.email_outlined),
//               SizedBox(height: 15.h),
//               _buildModernField(phoneController, "Phone Number", Icons.phone_android_outlined),
//
//               SizedBox(height: 25.h),
//               const Divider(height: 1, color: Color(0xffE2E2E2)),
//               SizedBox(height: 25.h),
//
//               StoreText(
//                 value: "Location Information (From Storage)",
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xff7C7C7C),
//               ),
//               SizedBox(height: 20.h),
//
//               // حقول الدولة والمدينة المسحوبة من الـ Local Storage
//               _buildModernField(countryController, "Country", Icons.public_outlined),
//               SizedBox(height: 15.h),
//               _buildModernField(cityController, "City", Icons.location_city_outlined),
//
//               SizedBox(height: 40.h),
//
//               // زر حفظ التغييرات المتناسق مع تصميم Figma
//               SizedBox(
//                 width: double.infinity,
//                 height: 65.h,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff53B175),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19).r),
//                     elevation: 0,
//                   ),
//                   onPressed: () {
//                     // 1. حفظ بيانات الاسم والجوال والايميل عبر الكنترولر للسيرفر
//                     widget.controller.updateUserName(
//                       firstName: fNameController.text.trim(),
//                       lastName: lNameController.text.trim(),
//                       email: emailController.text.trim(),
//                       phoneNumber: phoneController.text.trim(),
//                       countryCode: 'ps',
//                     );
//
//                     // 2. تحديث التخزين المحلي في حال قيام المستخدم بتعديل الدولة أو المدينة يدوياً
//                     storageService.write('country', countryController.text.trim());
//                     storageService.write('city', cityController.text.trim());
//
//                     Get.back(); // العودة للشاشة السابقة بعد إتمام الحفظ
//                   },
//                   child: Text(
//                     "Save Changes",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 25.h),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // الويدجت الموحدة لبناء الحقول الأنيقة للحفاظ على تماثل الشكل
//   Widget _buildModernField(TextEditingController controller, String hint, IconData icon) {
//     return TextField(
//       controller: controller,
//       style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: const Color(0xffF2F3F2),
//         hintText: hint,
//         hintStyle: TextStyle(color: const Color(0xff7C7C7C), fontSize: 14.sp),
//         prefixIcon: Icon(icon, color: const Color(0xff53B175), size: 22.sp),
//         contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15).r,
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15).r,
//           borderSide: const BorderSide(color: Color(0xff53B175), width: 1.5),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Auth/widgets/custome_dropdown_menu.dart';
import 'widgets/custem_textfeild_widget.dart';
import '../../../controllers/profile_controller.dart';
import '../../controllers/home_controller.dart';
import '../../core/localization/storaged_services.dart';
import '../widgets/store_text.dart';

// 💡 استيراد الوجدات الخارجية

class AccountDetailsScreen extends StatefulWidget {
  final ProfileController controller;

  const AccountDetailsScreen({super.key, required this.controller});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final formKey = GlobalKey<FormState>();

  // تعريف المتحكمات للحقول النصية
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  // 💡 متغيرات التحكم بالدولة والمدينة وقوائمهما
  String? selectedCountry;
  String? selectedCity;
  List<String> countries = [];
  List<String> cities = [];

  final storageService = Get.find<StorageService>();

  // 💡 خريطة البيانات المترابطة للدول والمدن
  final Map<String, List<String>> data = {
    "Palestine": ["Gaza", "Khan Yunis", "Rafah", "Nablus", "Ramallah"],
    "Jordan": ["Amman", "Zarqa", "Irbid"],
    "Egypt": ["Cairo", "Alexandria", "Giza"],
    "Saudi Arabia": ["Riyadh", "Jeddah", "Mecca"]
  };

  @override
  void initState() {
    super.initState();

    // تهيئة الحقول من بيانات الكنترولر الحالي
    fNameController = TextEditingController(text: widget.controller.currentUser?.firstName);
    lNameController = TextEditingController(text: widget.controller.currentUser?.lastName);
    emailController = TextEditingController(text: widget.controller.currentUser?.email);
    phoneController = TextEditingController(text: widget.controller.currentUser?.phone);

    // تجهيز قائمة الدول من مفاتيح الخريطة
    countries = data.keys.toList();

    // سحب بيانات الدولة والمدينة المخزنة داخل الـ Local Storage تلقائياً (zone و area)
    String? savedCountry = storageService.read('zone');
    String? savedCity = storageService.read('area');

    // التحقق الآمن لتهيئة القوائم دون حدوث كراش Dropdown
    if (countries.contains(savedCountry)) {
      selectedCountry = savedCountry;
      cities = List<String>.from(data[selectedCountry] ?? []);

      if (cities.contains(savedCity)) {
        selectedCity = savedCity;
      }
    }
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: StoreText(
          value: "Account Details",
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StoreText(
                  value: "Profile Information",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff7C7C7C),
                ),
                SizedBox(height: 20.h),

                // حقول الاسم الأول والأخير والبريد والجوال باستدعاء الـ Widget الخارجي
                CustomTextField(controller: fNameController, hint: "First Name", icon: Icons.person_outline),
                SizedBox(height: 15.h),
                CustomTextField(controller: lNameController, hint: "Last Name", icon: Icons.person_outline),
                SizedBox(height: 15.h),
                CustomTextField(controller: emailController, hint: "Email Address", icon: Icons.email_outlined),
                SizedBox(height: 15.h),
                CustomTextField(controller: phoneController, hint: "Phone Number", icon: Icons.phone_android_outlined),

                SizedBox(height: 25.h),
                const Divider(height: 1, color: Color(0xffE2E2E2)),
                SizedBox(height: 25.h),

                StoreText(
                  value: "Location Information (From Storage)",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff7C7C7C),
                ),
                SizedBox(height: 20.h),

                // 💡 تعديل: قائمة اختيار الدولة (Zone) الخارجية مع الحفظ الفوري
                CustomDropdownField(
                  value: selectedCountry,
                  hintText: "Select your zone",
                  icon: Icons.public_outlined,
                  items: countries,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please select your country";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value!;
                      selectedCity = null; // تصفير المدينة لمنع تضارب المدخلات
                      cities = (data[value] as List).cast<String>();

                      // 💾 تعديل وتحديث اللوكل ستوريج فوراً عند الاختيار
                      storageService.write('zone', selectedCountry);
                    });
                  },
                ),

                SizedBox(height: 20.h),

                // 💡 تعديل: قائمة اختيار المدينة (Area) الخارجية مع الحفظ الفوري
                CustomDropdownField(
                  value: selectedCity,
                  hintText: "Select City",
                  icon: Icons.location_city_outlined,
                  items: cities,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please select your area";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value!;

                      // 💾 تعديل وتحديث اللوكل ستوريج فوراً عند الاختيار
                      storageService.write('area', selectedCity);
                    });
                  },
                ),

                SizedBox(height: 40.h),
                SizedBox(
                  width: double.infinity,
                  height: 65.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff53B175),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19).r),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        widget.controller.updateUserName(
                          firstName: fNameController.text.trim(),
                          lastName: lNameController.text.trim(),
                          email: emailController.text.trim(),
                          phoneNumber: phoneController.text.trim(),
                          countryCode: 'ps',
                        );
                        storageService.write('zone', selectedCountry);
                        storageService.write('area', selectedCity);

                        if (Get.isRegistered<HomeController>()) {
                          Get.find<HomeController>().updateLocationFromStorage();
                        }

                        Get.back(); // العودة للشاشة السابقة بعد إتمام الحفظ
                      }
                    },
                    child: Text(
                      "Save Changes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}