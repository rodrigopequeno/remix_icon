import 'dart:math';
import 'package:recase/recase.dart';
import 'convert_number.dart';

export 'package:recase/recase.dart';

extension StringToName on String {
  String numberToWordCamelCase() {
    final text = camelCase;
    final reg = RegExp(r'^\d+(k|K)*');
    final match = reg.firstMatch(text);
    if (match != null) {
      final numberText = match.group(0);
      if (numberText == null) {
        throw Exception('unexpected mismatch');
      }
      final kCount =
          numberText.length - numberText.replaceAll(RegExp('(k|K)'), '').length;
      final number =
          int.parse(numberText.substring(0, numberText.length - kCount)) *
              pow(1000, kCount) as int;
      final word = number.toWord();
      final rest = text.substring(numberText.length);

      return word + rest.substring(0, 1).toUpperCase() + rest.substring(1);
    } else {
      return text;
    }
  }

  String get toCodePoint {
    return replaceAll('&#x', '').replaceAll(';', '');
  }
}

extension IntExtension on int? {
  String toWord() {
    return ConvertNumber(this).toString().camelCase;
  }
}
