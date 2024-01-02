// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:recase/recase.dart';
import 'package:remix_ic/src/remix_icon.dart';

void main() {
  group('constructor', () {
    test('should return instance of [RemixIcon]', () {
      expect(RemixIcon.constructor, isA<RemixIcon>());
    });
  });
  group('fromString', () {
    test('should return null when not found icon identifier', () {
      expect(RemixIcon.fromString('icon-not-found'), null);
    });
    test('should return IconData based in icon identifier', () {
      expect(
        RemixIcon.fromString('zoom-in-fill'),
        RemixIcon.zoomInFill,
      );
    });
  });

  group('getIconsIdentifier', () {
    test('should return all icon identifier', () {
      final result = RemixIcon.getIconsIdentifier();
      expect(result, isA<List<String>>());
      expect(result, isNotEmpty);
    });
  });

  group('iconMap', () {
    test('instance of [Map<String, int>]', () async {
      expect(iconMap, isA<Map<String, int>>());
    });

    test('all keys must be in "param-case" format', () async {
      for (final iconIdentifier in iconMap.keys) {
        expect(iconIdentifier, equals(iconIdentifier.paramCase));
      }
    });
  });
}
