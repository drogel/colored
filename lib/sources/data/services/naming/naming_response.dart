import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/network_client/response_wrapper.dart';
import 'package:colored/sources/domain/data_models/naming_result.dart';

class NamingResponse extends ResponseWrapper {
  const NamingResponse(ResponseStatus status, {this.result})
      : assert(status != null),
        super(status);

  final NamingResult? result;
}
