class ConvertNumber {
  ConvertNumber(this.number);
  final int? number;

  final ones = {
    'zero',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen',
  };
  final tens = [
    '',
    '',
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety',
  ];

  String convertNumberToWord(int? number) {
    if (number == null) return '';
    if (number < 20) {
      return ones.elementAt(number);
    } else if (number < 100) {
      return tens[number ~/ 10] +
          (number % 10 != 0 ? ' ${ones.elementAt(number % 10)}' : '');
    } else if (number < 1000) {
      return '''${ones.elementAt(number ~/ 100)} hundred${number % 100 != 0 ? ' ${convertNumberToWord(number % 100)}' : ''}''';
    } else {
      return '''${convertNumberToWord(number ~/ 1000)} thousand${number % 1000 != 0 ? ' ${convertNumberToWord(number % 1000)}' : ''}''';
    }
  }

  @override
  String toString() {
    return convertNumberToWord(number);
  }
}
