import 'dart:async';

import 'package:colored/sources/data/services/device_orientation/device_orientation_service.dart';
import 'package:colored/sources/data/services/local_storage/mock_local_storage.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDeviceOrientationService extends Mock
    implements DeviceOrientationService {}

void main() {
  late OnBoardingViewModel viewModel;
  late DeviceOrientationService service;

  setUp(() {
    service = MockDeviceOrientationService();
    viewModel = OnBoardingViewModel(
      stateController: StreamController<OnBoardingState>(),
      deviceOrientationService: service,
      localStorage: const MockLocalStorage(),
    );
  });

  tearDown(() {
    viewModel.dispose();
  });

  group("Given an OnBoardingViewModel with stubbed DeviceOrientationService",
      () {
    group("when init is called", () {
      test("then DeviceOrientationService sets portrait orientation", () {
        viewModel.init();
        verify(service.setPortraitOrientation());
      });
    });
  });
}
