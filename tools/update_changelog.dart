// ignore_for_file: avoid_print
import 'dart:io';

void main(List<String> arguments) {
  if (arguments.length != 1) {
    return;
  }

  final newVersion = arguments[0];
  const filePath = 'CHANGELOG.md';

  final file = File(filePath);
  if (!file.existsSync()) {
    print('File not found: $filePath');
    return;
  }

  final lines = file.readAsLinesSync();
  final versionPattern = RegExp(r'^## \d+\.\d+\.\d+');

  var insertIndex = -1;
  for (var i = 0; i < lines.length; i++) {
    if (versionPattern.hasMatch(lines[i])) {
      insertIndex = i;
      break;
    }
  }

  if (insertIndex == -1) {
    print('No version found in the changelog.');
    return;
  }

  lines
    ..insert(insertIndex, '')
    ..insert(
      insertIndex,
      '[Release](https://github.com/Remix-Design/RemixIcon/releases/tag/v$newVersion)',
    )
    ..insert(insertIndex, '')
    ..insert(insertIndex, '## $newVersion');

  file.writeAsStringSync(lines.join('\n'));
  print('Changelog updated with version $newVersion');
}
