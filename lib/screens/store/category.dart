import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../widgets/store_text.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffffffff),
        title: StoreText(value: "My Cart", color: Color(0xff181725), fontWeight: FontWeight.bold,
            fontSize: 20.sp),
      ),
      body: ScreenUtilInit(
        designSize: Size(414, 896),
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
