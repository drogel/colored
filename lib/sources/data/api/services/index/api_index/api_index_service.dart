import 'package:colored/sources/data/api/models/index/api_index.dart';

abstract class ApiIndexService {
  Future<ApiIndex?> fetchApiIndex();
}
