import 'package:colored/sources/data/network_client/response_status.dart';
import 'package:colored/sources/data/network_client/response_wrapper.dart';
import 'package:colored/sources/domain/data_models/naming_result.dart';

class PaletteNamingResponse extends ResponseWrapper {
  const PaletteNamingResponse(ResponseStatus status, {this.results})
      : assert(status != null),
        super(status);

  final List<NamingResult> results;
}
