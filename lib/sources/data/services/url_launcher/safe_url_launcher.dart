import 'package:colored/sources/data/services/url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class SafeUrlLauncher implements UrlLauncher {
  const SafeUrlLauncher({
    required String url,
    Future<void> Function(String) launchAction = launcher.launch,
    Future<bool> Function(String) canLaunchCheck = launcher.canLaunch,
  })  : _canLaunch = canLaunchCheck,
        _launchAction = launchAction,
        _url = url;

  final String _url;
  final Future<void> Function(String) _launchAction;
  final Future<bool> Function(String) _canLaunch;

  @override
  Future<void> launch() async {
    if (await _canLaunch(_url)) {
      await _launchAction(_url);
    }
  }
}
