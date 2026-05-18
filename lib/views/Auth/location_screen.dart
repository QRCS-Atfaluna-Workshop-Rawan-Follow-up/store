import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/screens/Auth/singin_screen.dart';
import 'package:store_app/screens/Auth/signup_screen.dart';
import 'package:store_app/widgets/store_elevated_btn.dart';
import 'package:store_app/widgets/store_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../services/json_service.dart';


class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  List<dynamic> countries = [];
  List<dynamic> cities = [];
  Map<String, dynamic> data = {};
  String? selectedCountry;
  String? selectedCity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _loadData();
  }
  void _loadData() async{
    Map <String,dynamic> allData= await JsonService.getLocations();
     setState(() {
       data= allData;
       countries = data.keys.toList();
     });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Padding(
        padding:  EdgeInsets.all(20).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15.h,
          children: [
            Image.asset("${AppAsset.imageUrl}location.png",width: 227.w,height: 170.h,),
            StoreText(value: "Select Your Location", color: Color(0xff181725),
                fontWeight: FontWeight.w500, fontSize: 26.sp),
            StoreText(value: "Swithch on your location to stay in tune with what’s happening in your area",
                color: Color(0xff7C7C7C), fontWeight: FontWeight.w300, fontSize: 16.sp,
              textAlign: TextAlign.center,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StoreText(value: "Your Zone", color: Color(0xff7C7C7C),
                      fontWeight: FontWeight.w300, fontSize: 16.sp),
                  DropdownButtonFormField<String>(
                    initialValue: selectedCountry,
                    hint:StoreText(value:"Select your zone",fontSize: 18.sp,
                      fontWeight: FontWeight.w300, color: Color(0xff7C7C7C),),
                    icon: Icon(Icons.keyboard_arrow_down),
                    decoration: _inputDecoration(),
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value;
                        selectedCity = null;
                        cities = List<String>.from(data[value]);
                      });
                    },
                  ),
                  SizedBox(height: 20.h,),
                  StoreText(value: "Your Area", color: Color(0xff7C7C7C),
                      fontWeight: FontWeight.w300, fontSize: 16.sp),
                  DropdownButtonFormField<String>(
                    initialValue: selectedCity,
                    hint: StoreText(value: "Select City",fontSize: 16.sp,
                      fontWeight: FontWeight.w300, color: Color(0xff121212),),
                    icon: Icon(Icons.keyboard_arrow_down),
                    decoration: _inputDecoration(),
                    items: cities.map((city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value;
                      });
                    },
                  )
                ],
              ),
            SizedBox(height: 25.h,),
            SizedBox(
              height: 60.h,
              width: 364.w,
              child: StoreElevatedBtn(value: "Submit", color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(15).r, onPressed: () {
                  // var logger = Logger();

                  // logger.d("Logger is working!");
                  // logger.t("logger is working");
                  // logger.w('logger is working');
                 // Future.delayed(Duration(seconds: 5),(){
                 //   EasyLoading.show(status: 'loading...');
                 //   EasyLoading.removeAllCallbacks();
                 // });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup(),));
                  },),
            )
          ],
        ),
      ),
    );
  }
}
InputDecoration _inputDecoration() {
  return InputDecoration(
    contentPadding:  EdgeInsets.symmetric(vertical: 8.h),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffE2E2E2), width: 1.5.w),
    ),
    focusedBorder:  UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF5DB075), width: 2.w),
    ),
  );
}
