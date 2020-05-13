import 'package:colored/sources/data/url_composer/url_composer.dart';

class ColorNamesComposer implements UrlComposer {
  const ColorNamesComposer();

  @override
  String compose(String baseUrl, {String path}) {
    final cleanEndpoint = path.replaceAll("#", "");
    return baseUrl + cleanEndpoint;
  }
}