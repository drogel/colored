import 'package:colored/sources/data/api/models/index/api_index.dart';

class Index {
  const Index({
    required this.apiIndex,
    required this.respositoryUri,
  });

  final ApiIndex apiIndex;
  final Uri respositoryUri;
}
