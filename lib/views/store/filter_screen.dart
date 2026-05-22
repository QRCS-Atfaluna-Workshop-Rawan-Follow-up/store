import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_color.dart';
import 'package:store_app/views/store/widgets/checkbox_list_tail.dart';

import '../widgets/store_text.dart';


class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<Map<String,dynamic>> checkBoxCategories= [
    {
      "title":"Eggs",
      "isChecked" : true
    },
    {
      "title":"Noodles & Pasta",
      "isChecked" : false
    },
    {
      "title":"Chips & Crisps",
      "isChecked" : false
    },
    {
      "title":"Fast Food",
      "isChecked" : false
    },
  ];
  List<Map<String,dynamic>> checkBoxBrands= [
    {
      "title":"Individual Collection",
      "isChecked" : true
    },
    {
      "title":"Ifad",
      "isChecked" : false
    },
    {
      "title":"Kazi Farms",
      "isChecked" : false
    },
    {
      "title":"Cocola",
      "isChecked" : false
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffffffff),
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.close,fontWeight: FontWeight.w500,size: 28.sp,)),
          title: StoreText(value: "Filters", color: Color(0xff181725), fontWeight: FontWeight.bold,
              fontSize: 22.sp)),
        body: Container(
          height:double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(15).r,
          margin: EdgeInsets.all(5).r,
          decoration: BoxDecoration(
            color: Color(0xffF2F3F2),
            borderRadius: BorderRadius.circular(19).r
          ),
          child: Padding(
            padding:  EdgeInsets.all(20).r,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              StoreText(value: "Categories", color: Color(0xff181725),
                      fontWeight:FontWeight.w600, fontSize: 22.sp),
                ListView.builder(
                  itemCount: checkBoxCategories.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                   return CheckboxListTileWidget(
                     text: "${checkBoxCategories[index]['title']}",value:
                     checkBoxCategories[index]['isChecked'], onChanged: (bool? value) {
                   setState(() {
                     checkBoxCategories[index]['isChecked'] = value!;
                   });
                   },);
                },),
                SizedBox(height: 15.h,),
            StoreText(value: "Brand", color: Color(0xff181725),
                      fontWeight: FontWeight.w600, fontSize: 22.sp),
                ListView.builder(
                  itemCount: checkBoxBrands.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CheckboxListTileWidget(
                      text: "${checkBoxBrands[index]['title']}",value:
                    checkBoxBrands[index]['isChecked'], onChanged: (bool? value) {
                      setState(() {
                        checkBoxBrands[index]['isChecked'] = value!;
                      });
                    },);
                  },),
               //  Column(
               //    spacing: 10.h,
               //   mainAxisAlignment: MainAxisAlignment.start,
               //   crossAxisAlignment: CrossAxisAlignment.start,
               //   children: [
               //
               //     CheckboxListTileWidget(text: "Individual Collection",value: true,
               //       onChanged: (bool? value) {
               //         setState(() {
               //           isChecked =value!;
               //         });
               //       },),
               //     CheckboxListTileWidget(text: "Ifad", onChanged: (bool? value) {
               //       setState(() {
               //         isChecked =value!;
               //       });
               //     },),
               //     CheckboxListTileWidget(text: "Kazi Farms ", onChanged: (bool? value) {
               //       setState(() {
               //         print(value);
               //         isChecked = value!;
               //       });
               //     },),
               //   ],
               // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


