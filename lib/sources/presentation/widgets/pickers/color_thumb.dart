import 'package:flutter/material.dart';

class ColorThumb extends StatelessWidget {
  const ColorThumb({
    @required this.color,
    Key key,
  })  : assert(color != null),
        super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) => ClipOval(
        child: Container(color: color),
      );
}
