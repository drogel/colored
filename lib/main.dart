import 'package:colored/sources/app/colored.dart';
import 'package:colored/sources/app/navigation/on_boarding_router.dart';
import 'package:colored/sources/data/services/local_storage/mock_local_storage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initialRoute = await OnBoardingRouter.getInitialRoute(
     const MockLocalStorage(),
  );

  runApp(Colored(initialRoute: initialRoute));
}
