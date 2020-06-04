import 'package:flutter/material.dart';

class ConnectivityLayout extends StatelessWidget {
  const ConnectivityLayout({Key key, this.child, this.body}) : super(key: key);

  final Widget child;
  final Widget body;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          if (body != null) body,
          if (child != null) child,
        ],
      );
}
