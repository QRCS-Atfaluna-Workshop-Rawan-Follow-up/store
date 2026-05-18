import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:store_app/screens/store/widgets/category_list_view.dart';
import 'package:store_app/screens/store/widgets/search_text_feild.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_asset.dart';
import '../../widgets/store_text.dart';
import 'filter_screen.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController searchController;
  List<Map<String,String>> searchResult = [
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
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 95.h,
          actionsPadding: EdgeInsetsGeometry.symmetric(vertical: 20.h,horizontal:10.w ),
          backgroundColor: Color(0xffffffff),
          title:  Form(
            key: formKey,
            child: SizedBox(
              height: 80.h,
              width: 400.w,
              child: SearchTextFeild(
                searchController: searchController,
                onSearchPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
                onFieldSubmitted: (value) {
                  if (formKey.currentState!.validate()) {}
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Entre the true value';
                  }
                  return null;
                },
              ),
            ),
          ),
            actions:[
              InkWell(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen(),));
              }, child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.h),
                child: SvgPicture.asset("${AppAsset.imageUrl}filter.svg",fit: BoxFit.none,

                ),
              )),]
        ),
        backgroundColor: Color(0xffffffff),
        body: ScreenUtilInit(
          designSize: Size(414, 896),
          child: SingleChildScrollView(
            child: Column(
              children: [
                    ListviewCategory(content: searchResult,childAspectRatio: 0.5/0.7,
                      crossAxisSpacing:5.w,mainAxisSpacing:15.h ,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
