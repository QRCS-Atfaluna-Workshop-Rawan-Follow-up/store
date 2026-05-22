
import 'package:flutter/material.dart';
import 'package:store_app/core/theme/app_asset.dart';
import 'package:store_app/views/store/widgets/search_text_feild.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_color.dart';
import '../widgets/store_text.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late final TextEditingController searchController;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController() ;
  }
  @override
  Widget build(BuildContext context) {
    List<Map<String,dynamic>> categories =[
      {
        "imageUrl":"${AppAsset.imageUrl}fruit.png",
        "title" :"Fresh Fruit & Vegetables",
      },{
        "imageUrl":"${AppAsset.imageUrl}oil.png",
        "title" :"Fresh Fruit & Vegetables",
      },
      {
        "imageUrl":"${AppAsset.imageUrl}meats.png",
        "title" :"Cooking oil & Ghee",
      },
      {
        "imageUrl":"${AppAsset.imageUrl}bread.png",
        "title" :"Bread & Snack",
      },{
        "imageUrl":"${AppAsset.imageUrl}milk.png",
        "title" :"Egg & Mild",
      },{
        "imageUrl":"${AppAsset.imageUrl}beverage.png",
        "title" :"Beverages",
      },
      {
        "imageUrl":"${AppAsset.imageUrl}milk.png",
        "title" :"Egg & Milk",
      },
      {
        "imageUrl":"${AppAsset.imageUrl}beverage.png",
        "title" :"Beverages",
      }

    ];

    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(414, 896),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xffffffff),
            title: StoreText(value: "Find Products",
                color: Color(0xff181725), fontWeight: FontWeight.bold,
                fontSize: 18.sp),
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xffffffff),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20).r,
              child: Column(
                spacing: 15.h,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: formKey,
                    child: SizedBox(
                      height: 150.h,
                      width: 364.w,
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
                  GridView.builder(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                    itemCount: categories.length,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                      childAspectRatio: 1.4/1.6
                    ),
                    shrinkWrap: true,
                    // padding: EdgeInsetsGeometry.all(0),
                    itemBuilder: (context, index) {
                      Color currentColor = AppColor.categoryColors[index % AppColor.categoryColors.length];
                        return Container(
                          padding: EdgeInsets.all(15).r,
                          transformAlignment: AlignmentGeometry.center,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                           color: currentColor.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(15).r,
                            border: BoxBorder.all(
                              color: currentColor.withValues(alpha: 0.9),
                              width: 2.w
                            )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Image.asset("${categories[index]['imageUrl']}",width:100.w,height: 100.h,
                              fit: BoxFit.contain,),
                              SizedBox(height: 10.h),
                              Expanded(
                                child: Center(
                                  child: StoreText(value: "${categories[index]['title']}",
                                      color: Color(0xff181725),
                                      fontWeight: FontWeight.w600, fontSize:15.sp,
                                    textAlign:TextAlign.center,),
                                ),
                              ),

                            ],
                          ),
                        );
                      },)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
