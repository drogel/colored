import 'package:flutter/widgets.dart';

abstract class Router extends StatefulWidget {
  const Router({Key key}) : super(key: key);

  Route<dynamic> buildInitialRoute(
      BuildContext context, {
        RouteSettings settings,
      });

  @override
  RouterState createState();
}

abstract class RouterState extends State<Router> {
  @override
  Widget build(BuildContext context) => Navigator(
    onGenerateRoute: (settings) => widget.buildInitialRoute(
      context,
      settings: settings,
    ),
  );
}
