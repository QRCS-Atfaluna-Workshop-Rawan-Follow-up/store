import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/store_text.dart';

class SingleCategory extends StatefulWidget {
  const SingleCategory({super.key});

  @override
  State<SingleCategory> createState() => _SingleCategoryState();
}

class _SingleCategoryState extends State<SingleCategory> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffffffff),
          title: StoreText(value: "Single Category", color: Color(0xff181725), fontWeight: FontWeight.bold,
              fontSize: 20.sp),
          leading: IconButton(onPressed: () {

          }, icon: Icon(Icons.filter)),
        ),
        body: Column(
          
        ),
      ),
    );
  }
}
