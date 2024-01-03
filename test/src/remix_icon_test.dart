// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_ic/src/remix_icon.dart';

void main() {
  group('constructor', () {
    test('should return instance of [RemixIcon]', () {
      expect(RemixIcon.constructor, isA<RemixIcon>());
    });
  });
}
