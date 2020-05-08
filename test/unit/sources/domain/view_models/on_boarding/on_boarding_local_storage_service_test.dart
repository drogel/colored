import 'dart:async';

import 'package:colored/sources/data/services/device_orientation/system_chrome_service.dart';
import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:colored/sources/data/services/local_storage/local_storage_keys.dart'
    as keys;
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LocalStorageStub extends Mock implements LocalStorage {}

void main() {
  OnBoardingViewModel viewModel;
  LocalStorage service;

  setUp(() {
    service = LocalStorageStub();
    viewModel = OnBoardingViewModel(
      stateController: StreamController<OnBoardingState>(),
      localStorage: service,
      deviceOrientationService: const SystemChromeService(),
    );
  });

  tearDown(() {
    viewModel.dispose();
    viewModel = null;
    service = null;
  });

  group("Given an OnBoardingViewModel with stubbed LocalStorage service", () {
    group("when onOnBoardingFinish is called", () {
      test("then LocalStorage is asked to store true for didOnBoard key", () {
        viewModel.onOnBoardingFinish();
        service.storeBool(key: keys.didOnBoard, value: true);
      });
    });
  });
}
