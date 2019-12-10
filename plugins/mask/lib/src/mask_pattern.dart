import 'package:flutter/services.dart'
    show TextInputFormatter, TextEditingValue;
import 'package:mask/mask.dart';

class MaskPattern extends TextInputFormatter {
  final String mask;

  MaskPattern(this.mask);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      composing: newValue.composing,
      selection: newValue.selection,
      text: Mask.applyMask(mask, newValue.text),
    );
  }
}
