import 'package:colored/sources/data/services/device_orientation/device_orientation_service.dart';
import 'package:flutter/services.dart';

class SystemChromeService implements DeviceOrientationService {
  const SystemChromeService();

  @override
  void setAllOrientations() =>
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  @override
  void setPortraitOrientation() => SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
}
