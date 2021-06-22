import 'package:flutter/services.dart';

RegExp checkFormatDate = RegExp(
    r'^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$');

//Đúng khi nhập dưới 10 số còn nhập nhiều hơn 10 số bị sai ????
RegExp checkFormatPhone = RegExp(r'(^(?:[+0]9)?[0-9]{10,11}$)');
RegExp checkFormatCMND = RegExp(r'(^(?:[+0]9)?[0-9]{9,12}$)');

// Nhập password phải có chữ, số, chữ in hoa, ký tự đặt biệt và độ dài tối thiểu là 8
String patternPassword =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
// Nhập password có chữ hoặc số và độ dài tối thiểu là 8
String patternPassword1 = r'^(?=.*?[a-zA-Z0-9]).{8,}$';
// Nhập password có chữ và số và độ dài tối thiểu là 6
String patternPassword2 = r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{6,}$';

RegExp checkFormatPassword = RegExp(patternPassword2);

//chua validate Address, Fullname

//validate quantity or degree
String patternNumber = r'[0-9]+[.,]?[0-9]*';
RegExp checkFormatNumber = RegExp(patternNumber);
//fomat money
RegExp checkFormatMoney = RegExp(r'^(?:\d{1,3},)+(\d{1,3}),?$|^\d{1,3}$');
// RegExp checkLengthMoney =
//     RegExp(r'^(?:\d{2,3},)+(\d{2,3}),?$|^\d{2,3}$[0-9]{6,}$');

//Add comma auto when input text money
class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
