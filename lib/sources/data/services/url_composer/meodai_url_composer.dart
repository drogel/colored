import 'package:colored/sources/data/services/url_composer/url_composer.dart';

class MeodaiUrlComposer implements UrlComposer {
  const MeodaiUrlComposer();

  @override
  String compose(String baseUrl, {String? path}) {
    if (path == null) {
      return baseUrl;
    }

    final cleanPath = path.replaceFirst("#", "");
    final pathAsColorNamesQueryList = cleanPath.replaceAll("#", ",");
    return "$baseUrl/$pathAsColorNamesQueryList";
  }
}
