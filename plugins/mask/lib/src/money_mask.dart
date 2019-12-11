import 'package:flutter/services.dart'
    show TextEditingValue, TextInputFormatter, TextSelection;
import 'package:mask/src/mask.dart';

class MoneyMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = Mask.applyMoneyMask(newValue.text);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: text.length,
        affinity: newValue.selection.affinity,
      ),
      composing: newValue.composing,
    );
  }
}
