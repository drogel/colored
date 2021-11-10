import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/configuration/flavor_type.dart';
import 'package:colored/resources/data_paths.dart' as data_paths;
import 'package:colored/sources/app/colored.dart';
import 'package:colored/sources/app/navigation/flow_router.dart';
import 'package:colored/sources/app/navigation/routers/main_router.dart';
import 'package:colored/sources/app/navigation/routers/on_boarding_router.dart';
import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/api/services/base/response/api_response_parser.dart';
import 'package:colored/sources/data/api/services/index/api_index/api_index_fetcher.dart';
import 'package:colored/sources/data/network_client/safe_http_client.dart';
import 'package:colored/sources/data/services/local_storage/local_storage.dart';
import 'package:colored/sources/data/services/local_storage/local_storage_keys.dart'
    as keys;
import 'package:colored/sources/data/services/local_storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(flavorType: FlavorType.localData);
  const apiIndexFetcher = ApiIndexFetcher(
    client: SafeHttpClient(),
    apiIndexLink: data_paths.apiIndexLink,
    parser: ApiResponseParser(),
  );
  final apiIndex = await apiIndexFetcher.fetchApiIndex();
  final initialFlowRouter = await _getInitialRoute(
    const SharedPreferences(),
    apiIndex: apiIndex,
  );
  runApp(Colored(router: initialFlowRouter));
}

Future<FlowRouter> _getInitialRoute(
  LocalStorage localStorage, {
  ApiIndex? apiIndex,
}) async {
  if (kIsWeb) {
    return MainRouter(apiIndex: apiIndex);
  } else {
    return _getMobileInitialRoute(localStorage, apiIndex: apiIndex);
  }
}

Future<FlowRouter> _getMobileInitialRoute(
  LocalStorage localStorage, {
  ApiIndex? apiIndex,
}) async {
  final didOnBoard = await localStorage.getBool(key: keys.didOnBoard);
  if (didOnBoard == null) {
    return const OnBoardingFlowRouter();
  }
  final mainRouter = MainRouter(apiIndex: apiIndex);
  const onBoardingRouter = OnBoardingFlowRouter();
  return didOnBoard ? mainRouter : onBoardingRouter;
}
