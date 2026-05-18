import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/store_text.dart';

class SearchTextFeild extends StatelessWidget {
  const SearchTextFeild({
    super.key,
    required this.searchController, this.validator,
    required this.onSearchPressed,
    this.onFieldSubmitted,
  });

  final TextEditingController searchController;
  final String? Function(String?)? validator;
  final VoidCallback onSearchPressed;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: IconButton(icon:Icon(Icons.search_outlined,fontWeight:FontWeight.w500,size: 28.sp,),onPressed:onSearchPressed,),
        // SvgPicture.asset("${AppAsset.imageUrl}search.svg",width: 10.w,height: 15.h,s),
        contentPadding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 20.w),
        fillColor: Color(0xffF2F3F2),
        hint: StoreText(value: "store search",
            color: Color(0xff7C7C7C), fontWeight: FontWeight.w400,
            fontSize: 15.sp),
        helperText: " ",
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20).r
        ),
      ),
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: TextInputAction.search,

    );
  }
}
