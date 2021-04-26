import 'package:colored/sources/data/services/url_launcher/safe_url_launcher.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class LaunchAction {
  Future<void> call(String url);
}

abstract class CanLaunchCheck {
  Future<bool> call(String url);
}

class LaunchActionStub implements LaunchAction {
  int timesCallWasInvoked = 0;

  @override
  Future<void> call(String url) async => timesCallWasInvoked++;
}

class CanLaunchCheckStub implements CanLaunchCheck {
  CanLaunchCheckStub({required this.canLaunch});

  final bool canLaunch;

  @override
  Future<bool> call(String url) async => canLaunch;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LaunchActionStub launchAction;
  late CanLaunchCheck canLaunchCheck;

  group("Given a SafeUrlLauncher with a valid URL", () {
    setUp(() {
      launchAction = LaunchActionStub();
      canLaunchCheck = CanLaunchCheckStub(canLaunch: true);
    });

    group("when launch is called", () {
      test("then the launchAction function is called", () async {
        const url = "https://google.com";
        final urlLauncher = SafeUrlLauncher(
          url: url,
          launchAction: launchAction,
          canLaunchCheck: canLaunchCheck,
        );
        await urlLauncher.launch();
        expect(launchAction.timesCallWasInvoked, equals(1));
      });
    });
  });

  group("Given a SafeUrlLauncher with an invalid URL", () {
    setUp(() {
      launchAction = LaunchActionStub();
      canLaunchCheck = CanLaunchCheckStub(canLaunch: false);
    });

    group("when launch is called", () {
      test("then the launchAction function is not called", () async {
        const url = "test";
        final urlLauncher = SafeUrlLauncher(
          url: url,
          launchAction: launchAction,
          canLaunchCheck: canLaunchCheck,
        );
        await urlLauncher.launch();
        expect(launchAction.timesCallWasInvoked, equals(0));
      });
    });
  });
}
