import 'package:connectivity/connectivity.dart';

abstract class ConnectivityService {
  Future<ConnectivityResult> checkConnectivity();
}
