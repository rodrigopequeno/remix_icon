import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_ic/src/models/models.dart';

void main() {
  test('constructor', () async {
    expect(const RemixIconData(0), isA<RemixIconData>());
  });

  test('instance of IconData', () async {
    expect(const RemixIconData(0), isA<IconData>());
  });
}
