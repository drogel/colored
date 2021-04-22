import 'package:colored/sources/data/services/naming/naming_response.dart';

abstract class NamingService {
  Future<NamingResponse> getNaming({required String hexColor});
}
