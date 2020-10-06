import 'package:colored/sources/data/network_client/response_status.dart';

class ResponseWrapper {
  const ResponseWrapper(this.status) : assert(status != null);

  final ResponseStatus status;
}