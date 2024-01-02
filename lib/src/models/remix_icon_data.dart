part of 'models.dart';

const _fontFamily = 'Remix';
const _fontPackage = 'remix_ic';

/// {@template remix_ic_data}
/// Icon Data for Remix Icon
/// {@endtemplate}
class RemixIconData extends IconData {
  /// {@macro remix_ic_data}
  ///
  /// [codePoint] is the unicode of the icon
  const RemixIconData(super.codePoint)
      : super(
          fontFamily: _fontFamily,
          fontPackage: _fontPackage,
        );
}
