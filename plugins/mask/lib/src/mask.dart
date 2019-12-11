class Mask {
  static String applyMask(String mask, String value) {
    Map<String, RegExp> translator = {
      "A": RegExp(r"[A-Za-z]"),
      "0": RegExp(r"[0-9]"),
      "@": RegExp(r"[A-Za-z0-9]"),
      "*": RegExp(r".*"),
    };
    String result = '';
    int maskCharIndex = 0;
    int valueCharIndex = 0;
    while (true) {
      if (maskCharIndex == mask.length) {
        break;
      }
      if (valueCharIndex == value.length) {
        break;
      }
      String maskChar = mask[maskCharIndex];
      String valueChar = value[valueCharIndex];
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex++;
        maskCharIndex++;
        continue;
      }
      if (translator.containsKey(maskChar)) {
        if (translator[maskChar].hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }
        valueCharIndex += 1;
        continue;
      }
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }
    return result;
  }

  static String applyMoneyMask(String value) {
    value = value.replaceAll(RegExp(r"\D"), "");
    value = value.replaceAllMapped(RegExp(r"(\d{1,2})$"), (m) => ",${m[1]}");
    return value.replaceAllMapped(
        RegExp(r"(\d)(?=(\d{3})+,\d{2})"), (m) => "${m[1]}.");
  }
}
