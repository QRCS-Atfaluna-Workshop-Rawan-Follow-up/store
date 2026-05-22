import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/store_text.dart';
class OTP extends StatefulWidget{
  const OTP({super.key});

  @override
  State<OTP> createState() =>_OTPState();
}
// class _OTPState extends State<OTP>{
//   late List<TextEditingController> otpControllers ;
//   late List<FocusNode> focusNodes ;
//   final keyForm = GlobalKey<FormState>();
//   Widget? errorHint;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     otpControllers = List.generate(5, (index)=>TextEditingController());
//     focusNodes = List.generate(5, (index) => FocusNode());
//     if (Get.arguments['otp'] != null) {
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     for(var controllers in otpControllers){
//       controllers.dispose();
//     }
//     for(var nodes in focusNodes){
//       nodes.dispose();
//     }
//     super.dispose();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return ScreenUtilInit(
//       designSize: Size(393, 852),
//       child: Scaffold(
//         appBar: AppBar(title: StoreText(value: "One Time Password",
//             color:Color(0xff121212), fontWeight: FontWeight.w500,
//             fontSize: 18.sp),),
//         backgroundColor: Color(0xffffffff),
//         body: Padding(
//           padding: const EdgeInsets.all(15).r,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             spacing: 15.h,
//             children: [
//               Center(
//                 child: Column(
//                   spacing: 15.h,
//                   children: [
//                     SvgPicture.asset("${AppAsset.imageUrl}colorful-carrot.svg",width: 70.w,height: 70.h,),
//                     Text("Enter OTP",style: TextStyle(
//                       fontSize: 32.sp,
//                       color:AppColor.mainColor,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: "Poppins-SemiBold",
//                     ),),
//                     Text("Enter the OTP code we just sent you on your registered Email/Phone number",
//                       textAlign:TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: Color(0xff61677D),
//                         fontWeight: FontWeight.w400,
//                       ),),
//                   ],
//                 ),
//               ),
//               Column(
//                 children: [
//                   Form(
//                     key: keyForm,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: List.generate(4,(index) => buildOPTForm(index),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20.h,),
//                   SizedBox(
//                     height: 60.h,
//                     width: 345.w,
//                     child: ElevatedButton(onPressed: (){
//                       if(keyForm.currentState!.validate()){
//                       }
//                     }, style:ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.mainColor,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14)
//                         )
//                     ),  child: Text("Reset Password",style: TextStyle(
//                         color: Color(0xffffffff),
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16.sp
//                     ),
//                     ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
//                 child: RichText(text: TextSpan(
//                     style: TextStyle(
//                       color: Color(0xff3B4054),
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     children: [
//                       TextSpan(text:'Didn’t get OTP?  '),
//                       TextSpan(text: 'Resend OTP',style: TextStyle(color: AppColor.mainColor))
//                     ]
//                 )),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
//   Widget buildOPTForm(int i){
//     return SizedBox(
//       width: 55.w,
//       height: 90.h,
//       child: TextFormField(
//         controller:otpControllers[i],
//         focusNode: FocusNode(),
//         validator: (value) {
//           if(value == null || value.isEmpty){
//             return "Is required";
//           }
//           if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//             return "Numbers only allowed";
//           }
//           return null;
//         },
//         maxLength: 1,
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           counterText: "",
//           filled: true,
//           error: errorHint,
//           helperText: " ",
//           fillColor: Color(0xffF5F9FE),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12).r,
//               borderSide: BorderSide(
//                   color: Color(0xffEAEFF5),
//                   width: 1
//               )
//
//           ),
//           errorStyle: TextStyle(
//               height:0.5.h
//           ),
//           contentPadding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 15.w),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(14).r,
//               borderSide: BorderSide.none
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14).r,
//             borderSide: BorderSide(
//                 color:Colors.red
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14).r,
//             borderSide: BorderSide(
//               color: AppColor.mainColor,
//             ),
//           ),
//         ),
//         onChanged: (value) {
//           if(value.isNotEmpty && i<4){
//             FocusScope.of(context).nextFocus();
//             focusNodes[i++];
//           }
//           if(value.isEmpty && i > 0){
//             FocusScope.of(context).previousFocus();
//             focusNodes[i--];
//           }
//         },
//       ),
//     );
//   }
// }
class _OTPState extends State<OTP> {
  // السيرفر يتوقع 4 أرقام فقط
  late List<TextEditingController> otpControllers;
  late List<FocusNode> focusNodes;
  final keyForm = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    otpControllers = List.generate(4, (index) => TextEditingController());
    focusNodes = List.generate(4, (index) => FocusNode());

    // تعبئة الكود تلقائياً إذا كان موجوداً في الـ arguments (للتسهيل في مرحلة التست)
    if (Get.arguments != null && Get.arguments['otp'] != null) {
      String code = Get.arguments['otp'].toString();
      for (int i = 0; i < code.length && i < 4; i++) {
        otpControllers[i].text = code[i];
      }
    }
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffffffff),
        title: StoreText(
          value: "One Time Password",
          color: const Color(0xff121212),
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
      ),
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15).r,
          child: Column(
            children: [
              SizedBox(height: 50.h),
              SvgPicture.asset("${AppAsset.imageUrl}colorful-carrot.svg", width: 70.w, height: 70.h),
              SizedBox(height: 15.h),
              Text("Enter OTP", style: TextStyle(
                fontSize: 32.sp,
                color: AppColor.mainColor,
                fontWeight: FontWeight.w600,
              )),
              Text(
                "Enter the OTP code we just sent you to your email: ${Get.arguments['email']}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: const Color(0xff61677D)),
              ),
              SizedBox(height: 30.h),
              Form(
                key: keyForm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) => buildOPTForm(index)),
                ),
              ),
              SizedBox(height: 40.h),
              SizedBox(
                height: 60.h,
                width: 345.w,
                child: ElevatedButton(
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      String fullCode = otpControllers.map((e) => e.text).join();
                      authController.verifyOtpCode(
                        email: Get.arguments['email'],
                        code: fullCode,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.mainColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text("Verify & Proceed", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOPTForm(int i) {
    return SizedBox(
      width: 55.w,
      height: 90.h,
      child: TextFormField(
        controller: otpControllers[i],
        focusNode: focusNodes[i],
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: const Color(0xffF5F9FE),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12).r,
            borderSide: const BorderSide(color: Color(0xffEAEFF5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12).r,
            borderSide: BorderSide(color: AppColor.mainColor),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && i < 3) {
            focusNodes[i + 1].requestFocus();
          } else if (value.isEmpty && i > 0) {
            focusNodes[i - 1].requestFocus();
          }
        },
        validator: (value) => (value == null || value.isEmpty) ? "" : null,
      ),
    );
  }
}