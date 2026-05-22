import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/store_text.dart';

class MainSectionListView extends StatelessWidget {
  const MainSectionListView({
    super.key,
    required this.mainSections,
  });

  final List<Map<String, dynamic>> mainSections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 2,
      shrinkWrap: true,
      padding: EdgeInsetsGeometry.all(0.r),
      itemBuilder: (context, index) {
        return Container(
          height: 90.h,
          width: 250.w,
          margin: EdgeInsets.all(15).r,
          decoration: BoxDecoration(
              color: mainSections[index]['backgroundColor'],
              borderRadius: BorderRadius.circular(15).r
          ),
          child: Row(
            spacing: 15.w,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("${mainSections[index]['imageUrl']}",
                width: 120.w,height: 120.h,),
              StoreText(value: mainSections[index]['title'], color: Color(0xff3E423F), fontWeight:
              FontWeight.w500, fontSize: 20.sp)
            ],
          ),
        );
      },);
  }
}