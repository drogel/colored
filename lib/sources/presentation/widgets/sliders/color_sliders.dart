import 'package:colored/sources/presentation/widgets/sliders/color_slider.dart';
import 'package:colored/sources/style/colors.dart' as colors;
import 'package:flutter/material.dart';

class ColorSliders extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          ColorSlider(
            initialValue: 0.5,
            color: colors.red,
            onChanged: (_) {},
          ),
          ColorSlider(
            initialValue: 0.5,
            color: colors.green,
            onChanged: (_) {},
          ),
          ColorSlider(
            initialValue: 0.5,
            color: colors.blue,
            onChanged: (_) {},
          ),
        ],
      );
}
