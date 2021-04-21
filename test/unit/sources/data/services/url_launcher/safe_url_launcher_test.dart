import 'package:colored/sources/data/services/url_launcher/safe_url_launcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLaunchAction extends Mock {
  Future<void> call(String url);
}

class MockCanLaunchCheck extends Mock {
  Future<bool> call(String url);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Future<void> Function(String)? launchAction;
  Future<bool> Function(String)? canLaunchCheck;

  setUp(() {
    launchAction = MockLaunchAction() as Future<void> Function(String)?;
    canLaunchCheck = MockCanLaunchCheck() as Future<bool> Function(String)?;
  });

  tearDown(() {
    launchAction = null;
    canLaunchCheck = null;
  });

  group("Given a SafeUrlLauncher", () {
    group("when constructed", () {
      test("an assertion error should throw if url is null", () {
        expect(
          () => SafeUrlLauncher(url: null),
          throwsAssertionError,
        );
      });

      test("an assertion error should throw if launchAction is null", () {
        expect(
          () => SafeUrlLauncher(url: "test", launchAction: null),
          throwsAssertionError,
        );
      });

      test("an assertion error should throw if launchAction is null", () {
        expect(
          () => SafeUrlLauncher(url: "test", canLaunchCheck: null),
          throwsAssertionError,
        );
      });
    });
  });

  group("Given a SafeUrlLauncher with a valid URL", () {
    group("when launch is called", () {
      test("then the launchAction function is called", () async {
        const url = "https://google.com";
        when(canLaunchCheck!(url)).thenAnswer((realInvocation) async => true);
        final urlLauncher = SafeUrlLauncher(
          url: url,
          launchAction: launchAction!,
          canLaunchCheck: canLaunchCheck!,
        );

        await urlLauncher.launch();

        verify(launchAction!.call(url));
      });
    });
  });

  group("Given a SafeUrlLauncher with an invalid URL", () {
    group("then launch is called", () {
      test("then the launchAction function is not called", () async {
        const url = "test";
        when(canLaunchCheck!(url)).thenAnswer((realInvocation) async => false);
        final urlLauncher = SafeUrlLauncher(
          url: url,
          launchAction: launchAction!,
          canLaunchCheck: canLaunchCheck!,
        );

        await urlLauncher.launch();

        verifyNever(launchAction!.call(any!));
      });
    });
  });
}
