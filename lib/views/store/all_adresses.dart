import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/views/widgets/store_text.dart'; // 💡 استيراد الـ Widget الخاص بكِ
import '../../controllers/address_controller.dart';
import '../../routes/app_routes.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  StoreText(
          value: "Shipping Addresses",
          color: Color(0xff181725),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new, color:  Color(0xff181725), size: 20.sp),
        ),
      ),

      // ✨ استخدام الـ GetBuilder مع استدعاء دالة الفيتش فوراً عند فتح الصفحة
      body: GetBuilder<AddressController>(
        init: Get.find<AddressController>()..fetchAddresses(),
        builder: (controller) {
          if (controller.isLoading) {
            return  Center(
              child: CircularProgressIndicator(
                color: Colors.green, // متناسق مع هوية المتجر
              ),
            );
          }
          if (controller.addressList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off_outlined, size: 60.sp, color: Colors.grey.shade400),
                  SizedBox(height: 10.h),
                  StoreText(
                    value: "No addresses added yet",
                    color: Colors.grey.shade600,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(15.r),
            itemCount: controller.addressList.length,
            itemBuilder: (context, index) {
              final addressItem = controller.addressList[index];
              return Card(
                elevation: 0,
                margin: EdgeInsets.only(bottom: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: Colors.grey.shade200, width: 1), // حواف ناعمة مريحة للعين
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  leading: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.location_on_rounded, color: Colors.green, size: 24.sp),
                  ),
                  title: StoreText(
                    value: addressItem.title ?? "Address",
                    color: const Color(0xff181725),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: StoreText(
                      value: "${addressItem.city}, ${addressItem.area}, ${addressItem.addressType}",
                      color: const Color(0xff7C7C7C),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 📝 زر التعديل (يُمرر العنوان كـ Argument ويتحول وضع الشاشة تلقائياً لـ PUT)
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                        onPressed: () async {
                          var result = await Get.toNamed(AppRoutes.addAddress, arguments: addressItem);
                          if (result == true) controller.fetchAddresses();
                        },
                      ),
                      // 🗑️ زر الحذف المتكامل مع الـ Alert Dialog
                      // IconButton(
                      //   icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                      //   onPressed: () {
                      //     Get.defaultDialog(
                      //       title: "Delete Address",
                      //       titleStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xff181725)),
                      //       middleText: "Are you sure you want to delete this address?",
                      //       middleTextStyle: TextStyle(fontSize: 14.sp, color: const Color(0xff7C7C7C)),
                      //       textConfirm: "Yes, Delete",
                      //       textCancel: "Cancel",
                      //       confirmTextColor: Colors.white,
                      //       buttonColor: Colors.red,
                      //       cancelTextColor: Colors.grey.shade600,
                      //       onConfirm: () {
                      //         controller.deleteAddress(addressItem.id!);
                      //         Get.back(); // إغلاق الدايلوج تلقائياً
                      //       },
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      // ➕ زر إضافة عنوان جديد (يُمرر null لتعرف الشاشة التالية أنها في وضع الـ POST)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        elevation: 3,
        onPressed: () async {
          var result = await Get.toNamed(AppRoutes.addAddress, arguments: null);
          if (result == true) {
            Get.find<AddressController>().fetchAddresses();
          }
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}