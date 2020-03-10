import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/data_models/color_format.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/presentation/widgets/buttons/titled_clipboard_button.dart';
import 'package:colored/sources/presentation/widgets/containers/overlay_container.dart';
import 'package:colored/sources/presentation/widgets/containers/swiping_color_container.dart';
import 'package:colored/sources/presentation/widgets/sliders/color_sliders.dart';
import 'package:flutter/material.dart';

class ConverterLayout extends StatelessWidget {
  const ConverterLayout();

  @override
  Widget build(BuildContext context) {
    final data = ConverterData.of(context);
    final localization = Localization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.colorConverter),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          SwipingColorContainer(color: data.state.color),
          OverlayContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TitledClipboardButton(
                        title: localization.hex,
                        format: ColorFormat.hex,
                        clipboardShouldFail: data.clipboardShouldFail,
                        onClipboardRetrieved: data.onClipboardRetrieved,
                        content: data.state.hexString,
                      ),
                      Icon(Icons.compare_arrows),
                      TitledClipboardButton(
                        title: localization.rgb,
                        format: ColorFormat.rgb,
                        clipboardShouldFail: data.clipboardShouldFail,
                        onClipboardRetrieved: data.onClipboardRetrieved,
                        content: data.state.rgbString,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ColorSliders(
                  firstValue: data.state.selection.firstComponent,
                  secondValue: data.state.selection.secondComponent,
                  thirdValue: data.state.selection.thirdComponent,
                  onChanged: data.onSelectionChanged,
                  step: data.state.converterStep,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
