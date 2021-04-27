import 'dart:async';

import 'package:colored/sources/data/services/device_orientation/system_chrome_service.dart';
import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:colored/sources/data/services/local_storage/local_storage_keys.dart'
    as keys;
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

class LocalStorageStub implements LocalStorage {
  int timesCalledStoreBoolWithTrueValue = 0;

  @override
  Future<bool?> getBool({required String key}) async => true;

  @override
  Future<bool> storeBool({required String key, required bool value}) async {
    if (value) {
      timesCalledStoreBoolWithTrueValue++;
    }
    return true;
  }
}

void main() {
  late OnBoardingViewModel viewModel;
  late LocalStorageStub service;

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
  });

  group("Given an OnBoardingViewModel with stubbed LocalStorage service", () {
    group("when onOnBoardingFinish is called", () {
      test("then LocalStorage is asked to store true for didOnBoard key", () {
        viewModel.onOnBoardingFinish();
        expect(service.timesCalledStoreBoolWithTrueValue, equals(1));
      });
    });
  });
}
