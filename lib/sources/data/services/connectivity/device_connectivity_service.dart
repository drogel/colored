import 'package:colored/sources/data/services/connectivity/connectivity_service.dart';
import 'package:connectivity/connectivity.dart';

class DeviceConnectivityService implements ConnectivityService {
  DeviceConnectivityService() : _connectivity = Connectivity();

  final Connectivity _connectivity;

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
