import 'package:connectivity/connectivity.dart';

abstract class ConnectivityService {
  Stream<ConnectivityResult> get onConnectivityChanged;
}
