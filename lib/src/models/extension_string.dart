part of 'models.dart';

/// Extension for String
extension StringToName on String {
  /// Convert string to PascalCase
  String get paramCase {
    return ReCase(this).paramCase;
  }
}
