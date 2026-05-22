import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/views/store/widgets/category_list_view.dart';
import '../widgets/store_text.dart';
import 'filter_screen.dart';

class SingleCategory extends StatefulWidget {
  const SingleCategory({super.key});

  @override
  State<SingleCategory> createState() => _SingleCategoryState();
}

class _SingleCategoryState extends State<SingleCategory> {
  List<Map<String, String>> singleCategoryItems = [
  {
  "imageUrl": "${AppAsset.imageUrl}product1.png",
  "title": "Organic Banan",
  "subtitle": "1kg,Price",
  "price": "4.99",
},{
      "imageUrl": "${AppAsset.imageUrl}product2.png",
      "title": "Organic Banan",
      "subtitle": "1kg,Price",
      "price": "4.99",
    },{
      "imageUrl": "${AppAsset.imageUrl}product3.png",
      "title": "Organic Banan",
      "subtitle": "1kg,Price",
      "price": "4.99",
    },{
      "imageUrl": "${AppAsset.imageUrl}product7.png",
      "title": "Organic Banan",
      "subtitle": "1kg,Price",
      "price": "4.99",
    },{
      "imageUrl": "${AppAsset.imageUrl}product8.png",
      "title": "Organic Banan",
      "subtitle": "1kg,Price",
      "price": "4.99",
    },
    {
      "imageUrl": "${AppAsset.imageUrl}product6.png",
      "title": "Organic Banan",
      "subtitle": "1kg,Price",
      "price": "4.99",
    },
  ];
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
          actions:[
            InkWell(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen(),));
          }, child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15).r,
            child: SvgPicture.asset("${AppAsset.imageUrl}filter.svg",
             ),
          )),]
        ),
        body: SingleChildScrollView(
          child:
              ListviewCategory(content: singleCategoryItems,)
        ),
      ),
    );
  }
}


