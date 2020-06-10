import 'package:flutter/cupertino.dart';

abstract class HueCanvas extends StatelessWidget {
  const HueCanvas({@required this.hue, Key key})
      : assert(hue != null),
        super(key: key);

  final double hue;
}
