import 'package:colored/sources/presentation/widgets/sliders/color_sliders.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: ColorSliders(
          initialFirstValue: 0.5,
          initialSecondValue: 0.5,
          initialThirdValue: 0.5,
          onChanged: (_) {},
        ),
      );
}
