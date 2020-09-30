import 'package:colored/sources/data/services/url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class SafeUrlLauncher implements UrlLauncher {
  const SafeUrlLauncher({@required String url})
      : assert(url != null),
        _url = url;

  final String _url;

  @override
  Future<void> launch() async {
    if (await launcher.canLaunch(_url)) {
      await launcher.launch(_url);
    }
  }
}
