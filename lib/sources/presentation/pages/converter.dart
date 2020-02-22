import 'package:colored/sources/domain/inherited/converter/converter_data.dart';
import 'package:colored/sources/presentation/widgets/buttons/secondary_raised_button.dart';
import 'package:colored/sources/presentation/widgets/containers/overlay_container.dart';
import 'package:colored/sources/presentation/widgets/sliders/color_sliders.dart';
import 'package:flutter/material.dart';

class Converter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final converterData = ConverterData.of(context);
    final colorLabelsTextStyle = Theme.of(context).textTheme.headline;
    return Scaffold(
      appBar: AppBar(title: const Text("Color converter")),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(color: converterData.state.color),
          OverlayContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SecondaryRaisedButton(
                        onPressed: () {},
                        child: Text("#FF01F2", style: colorLabelsTextStyle),
                      ),
                      SecondaryRaisedButton(
                        onPressed: () {},
                        child: Text(
                          converterData.state.rgbComponents,
                          style: colorLabelsTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ColorSliders(
                  initialFirstValue: 0.5,
                  initialSecondValue: 0.5,
                  initialThirdValue: 0.5,
                  onChanged: converterData.onSelectionChanged,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
