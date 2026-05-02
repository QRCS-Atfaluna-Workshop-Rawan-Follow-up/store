import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreText extends StatelessWidget {
  final Color color;
  final String value;
  final FontWeight fontWeight;
  final double fontSize;
  final int maxLine;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  const StoreText({
    super.key,
    this.textOverflow ,
    this.textAlign ,
    this.maxLine = 2,
    required this.value,
    required this.color,
    required this.fontWeight,
    required this.fontSize,

  });

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      overflow:textOverflow ,
      maxLines: maxLine,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
