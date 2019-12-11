import 'package:flutter/services.dart'
    show TextEditingValue, TextInputFormatter, TextSelection;
import 'package:mask/mask.dart';

class MaskPattern extends TextInputFormatter {
  final String mask;

  MaskPattern(this.mask);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = Mask.applyMask(mask, newValue.text);
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
