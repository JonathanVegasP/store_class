import 'package:flutter/services.dart'
    show TextInputFormatter, TextEditingValue;
import 'package:mask/src/mask.dart';

class MoneyMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: Mask.applyMoneyMask(newValue.text),
      selection: newValue.selection,
      composing: newValue.composing,
    );
  }
}
