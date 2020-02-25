import 'package:colored/sources/domain/data/color_format.dart';
import 'package:colored/sources/domain/inherited/converter/converter_data.dart';
import 'package:colored/sources/presentation/widgets/buttons/clipboard_button.dart';
import 'package:colored/sources/presentation/widgets/containers/overlay_container.dart';
import 'package:colored/sources/presentation/widgets/sliders/color_sliders.dart';
import 'package:flutter/material.dart';

class Converter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = ConverterData.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Color converter")),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(color: data.state.color),
          OverlayContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ClipboardButton(
                        format: ColorFormat.hex,
                        clipboardShouldFail: data.clipboardShouldFail,
                        onClipboardRetrieved: data.onClipboardRetrieved,
                        onClipboardSet: data.onClipboardSet,
                        title: data.state.hexString,
                      ),
                      ClipboardButton(
                        format: ColorFormat.rgb,
                        clipboardShouldFail: data.clipboardShouldFail,
                        onClipboardRetrieved: data.onClipboardRetrieved,
                        onClipboardSet: data.onClipboardSet,
                        title: data.state.rgbString,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ColorSliders(
                  initialFirstValue: data.state.selection.firstComponent,
                  initialSecondValue: data.state.selection.secondComponent,
                  initialThirdValue: data.state.selection.thirdComponent,
                  onChanged: data.onSelectionChanged,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
