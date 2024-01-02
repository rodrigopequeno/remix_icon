import 'dart:convert';
import 'dart:io';

class Download {
  Download({
    required this.link,
    required this.path,
  });

  final String link;
  final String path;

  Future<dynamic> download() {
    return HttpClient()
        .getUrl(Uri.parse(link))
        .then((request) => request.close())
        .then(
          (response) => response.pipe(File(path).openWrite()),
        );
  }

  Future<Map<String, dynamic>> getMap() {
    return HttpClient()
        .getUrl(Uri.parse(link))
        .then((request) => request.close())
        .then(
      (response) async {
        final st = await response.transform(utf8.decoder).join();
        return json.decode(st) as Map<String, dynamic>;
      },
    );
  }
}
