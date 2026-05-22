import 'package:flutter/services.dart';

class SpacedTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(' ', ''); // حذف المسافات القديمة
    String newText = '';

    for (int i = 0; i < text.length; i++) {
      newText += text[i];
      if (i != text.length - 1) {
        newText += '  '; // إضافة مسافتين بين كل رقم
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}