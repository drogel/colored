import 'package:colored/sources/data/services/url_composer/url_composer.dart';

class ColorNamesComposer implements UrlComposer {
  const ColorNamesComposer();

  @override
  String compose(String baseUrl, {String path}) {
    if (path == null) {
      return baseUrl;
    }

    final cleanPath = path.replaceAll("#", "");
    return "$baseUrl/$cleanPath";
  }
}
