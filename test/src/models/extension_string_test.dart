import 'package:flutter_test/flutter_test.dart';
import 'package:remix_ic/src/models/models.dart';

void main() {
  const tText = 'Lorem ipsum-Dolor_sitAmet, ConsecteturAdipiscing?';
  group('paramCase', () {
    test('when empty string.', () {
      expect(''.paramCase, equals(''));
    });

    test('when $tText', () {
      expect(
        tText.paramCase,
        equals('lorem-ipsum-dolor-sit-amet,-consectetur-adipiscing?'),
      );
    });
  });
}
