import 'package:colored/sources/presentation/widgets/containers/overlay_container.dart';
import 'package:colored/sources/presentation/widgets/sliders/color_sliders.dart';
import 'package:flutter/material.dart';

class Converter extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Color converter")),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              color: Colors.orange[300],
            ),
            OverlayContainer(
              child: ColorSliders(
                initialFirstValue: 0.5,
                initialSecondValue: 0.5,
                initialThirdValue: 0.5,
                onChanged: (_) {},
              ),
            )
          ],
        ),
      );
}
