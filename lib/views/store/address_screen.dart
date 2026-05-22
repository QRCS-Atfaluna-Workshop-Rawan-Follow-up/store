import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:store_app/views/Auth/widgets/text_form_field.dart';
import 'package:store_app/views/widgets/store_elevated_btn.dart';
import 'package:store_app/views/widgets/store_text.dart';
import '../../controllers/address_controller.dart';
import '../../core/theme/app_color.dart';
import '../../data/models/adress_model.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final formKey = GlobalKey<FormState>();
final addressController  = Get.find<AddressController>();
  // متغيرات لمعرفة هل الشاشة في وضع التعديل أم الإضافة
  AddressModel? argumentAddress;
  bool isEditMode = false;

  // تعريف الـ Controllers
  late final TextEditingController typeController;
  late final TextEditingController nameController;
  late final TextEditingController cityController;
  late final TextEditingController blockController;
  late final TextEditingController buildingController;
  late final TextEditingController mobileController;
  late final TextEditingController areaController;

  @override
  void initState() {
    super.initState();

    // 🎯 1. استقبال البيانات الممررة من الشاشة السابقة (إن وجدت)
    argumentAddress = Get.arguments as AddressModel?;
    isEditMode = argumentAddress != null;

    // 🎯 2. تهيئة الـ Controllers: إذا كان وضع تعديل تظهر القيمة القديمة، وإلا تظهر فارغة
    typeController = TextEditingController(
      text: isEditMode ? argumentAddress!.addressType : "Home",
    );
    nameController = TextEditingController(
      text: isEditMode ? argumentAddress!.recipientName : "",
    );
    cityController = TextEditingController(
      text: isEditMode ? argumentAddress!.city : "",
    );
    blockController = TextEditingController(
      text: isEditMode ? argumentAddress!.block : "",
    );
    buildingController = TextEditingController(
      text: isEditMode ? argumentAddress!.buildingNumber : "",
    );
    mobileController = TextEditingController(
      text: isEditMode ? argumentAddress!.mobile : "",
    );
    areaController = TextEditingController(
      text: isEditMode ? argumentAddress!.area : "",
    );
  }

  @override
  void dispose() {
    // إغلاق الـ Controllers عند تدمير الشاشة لمنع تسريب الذاكرة
    typeController.dispose();
    nameController.dispose();
    cityController.dispose();
    blockController.dispose();
    buildingController.dispose();
    mobileController.dispose();
    areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // 🔄 تغيير العنوان ديناميكياً بحسب حالة الشاشة
        title: StoreText(
          value: isEditMode ? "Update Address" : "Add New Address",
          color: const Color(0xff181725),
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new, color: const Color(0xff181725), size: 20.sp),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14.h,
              children: [
                _buildFieldLabel("Address Type (e.g., Home, Work)"),
                StoreTextFormField(
                  value: "Home or Work",
                  Controller: typeController,
                  validator: (v) => v!.isEmpty ? "Required field" : null,
                ),

                _buildFieldLabel("Recipient Name"),
                StoreTextFormField(
                  value: "Enter recipient name",
                  Controller: nameController,
                  validator: (v) => v!.isEmpty ? "Required field" : null,
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6.h,
                        children: [
                          _buildFieldLabel("City"),
                          StoreTextFormField(
                            value: "City",
                            Controller: cityController,
                            validator: (v) => v!.isEmpty ? "Required" : null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6.h,
                        children: [
                          _buildFieldLabel("Area"),
                          StoreTextFormField(
                            value: "Area",
                            Controller: areaController,
                            validator: (v) => v!.isEmpty ? "Required" : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6.h,
                        children: [
                          _buildFieldLabel("Block"),
                          StoreTextFormField(
                            value: "Block",
                            Controller: blockController,
                            validator: (v) => v!.isEmpty ? "Required" : null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6.h,
                        children: [
                          _buildFieldLabel("Building No."),
                          StoreTextFormField(
                            value: "Building",
                            Controller: buildingController,
                            validator: (v) => v!.isEmpty ? "Required" : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                _buildFieldLabel("Mobile Number"),
                StoreTextFormField(
                  value: "626289262",
                  Controller: mobileController,
                  keyboardType: TextInputType.phone,
                  validator: (v) => v!.isEmpty ? "Required field" : null,
                ),

                SizedBox(height: 20.h),

                Center(
                  child: SizedBox(
                    height: 55.h,
                    width: 364.w,
                    child: StoreElevatedBtn(
                      value: isEditMode ? "Update Address" : "Save Address", // 🔄 تغيير النص
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(12).r,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (isEditMode) {
                             addressController.updateAddress(
                                  id: argumentAddress!.id!,
                                  title: typeController.text.trim(), // أو الحقل المخصص للعنوان لديكِ
                                  recipientName: nameController.text.trim(),
                                  city: cityController.text.trim(),
                                  area: areaController.text.trim(),
                                  mobile: mobileController.text.trim(),
                               block: int.parse(blockController.text.trim()),
                               buildingNumber: int.parse(buildingController.text.trim()),
                                );
                          } else {
                            addressController.addNewAddress(
                              addressType: typeController.text.trim(),
                              recipientName: nameController.text.trim(),
                              city: cityController.text.trim(),
                              block: blockController.text.trim(),
                              buildingNumber: buildingController.text.trim(),
                              countryCode: "+966",
                              mobile: mobileController.text.trim(),
                              latitude: "6229.629",
                              longitude: "9598.9598",
                              area: areaController.text.trim(),
                            );
                          }

                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return StoreText(
      value: label,
      color: const Color(0xff181725),
      fontWeight: FontWeight.w600,
      fontSize: 14.sp,
    );
  }
}