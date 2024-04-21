// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'models/download.dart';
import 'models/extensions.dart';
import 'models/icon_info.dart';
import 'models/remix_icon_info.dart';

const lastVersionUrl =
    'https://api.github.com/repos/Remix-Design/RemixIcon/releases/latest';
const _mdiRepo = 'https://raw.githubusercontent.com/Remix-Design/RemixIcon';
const _fontFileName = 'remixicon.ttf';
const _glyphFileName = 'remixicon.glyph.json';

Future<void> main() async {
  final result = await Download(
    link: lastVersionUrl,
    path: '',
  ).getMap();
  final latestVersionName = result['tag_name'] as String;
  final fontPath = '$_mdiRepo/$latestVersionName/fonts';
  print('Downloading latest remix icon');
  await Download(
    link: '$fontPath/$_fontFileName',
    path: './tools/$_fontFileName',
  ).download();
  await Download(
    link: '$fontPath/$_glyphFileName',
    path: './tools/$_glyphFileName',
  ).download();
  print('Parsing');
  final info = await readGlyphJson(latestVersionName);
  print('Generating');
  await generateCode(
    pathTemplate: './tools/templates/remix_icon.dart.template',
    pathDestiny: './lib/src/remix_icon.dart',
    icons: info.icons,
  );
  File('./tools/$_fontFileName').renameSync('./lib/fonts/$_fontFileName');
  File('./tools/$_glyphFileName').deleteSync();
  exit(0);
}

Future<RemixIconInfo> readGlyphJson(String versionName) async {
  final glyphFile = File('./tools/$_glyphFileName');
  if (!glyphFile.existsSync()) {
    print('config file not found');
    exit(0);
  }

  final content = glyphFile.readAsStringSync();
  final parsedContent = json.decode(content) as Map<String, dynamic>;
  final icons = <IconInfo>[];
  parsedContent.forEach((String key, dynamic value) {
    final iconInfo = IconInfo(
      name: key.numberToWordCamelCase(),
      identifier: key,
      codePoint:
          ((value as Map<String, dynamic>)['unicode'] as String).toCodePoint,
    );
    icons.add(iconInfo);
  });

  return RemixIconInfo(
    icons: icons,
    version: versionName.replaceAll('v', ''),
  );
}

Future<void> generateCode({
  required String pathTemplate,
  required String pathDestiny,
  required List<IconInfo> icons,
}) async {
  final templateFile = await File(pathTemplate).readAsString();
  final match = RegExp('<%(.*?)%>', multiLine: true, dotAll: true)
      .firstMatch(templateFile);
  if (match != null) {
    final placeholder = match.group(0);
    if (placeholder == null) {
      throw Exception('Missing placeholder');
    }
    final templateStatement = match.group(1);
    if (templateStatement == null) {
      throw Exception('Missing templateStatement');
    }
    final generated = templateFile.replaceAll(
      placeholder,
      icons.map((icon) {
        return templateStatement
            .replaceAll('__ICON_IDENTIFIER__', icon.identifier)
            .replaceAll('__ICON_NAME__', icon.name)
            .replaceAll('__CODE_POINT__', '0x${icon.codePoint}');
      }).join('\n'),
    );
    await File(pathDestiny).writeAsString(generated);
  }
}
