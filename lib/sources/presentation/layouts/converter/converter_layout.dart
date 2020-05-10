import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/domain/view_models/naming/naming_data.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_body_layout.dart';
import 'package:colored/sources/presentation/widgets/containers/swiping_color_container.dart';
import 'package:colored/sources/presentation/widgets/texts/naming_cross_fade_text.dart';
import 'package:flutter/material.dart';

class ConverterLayout extends StatelessWidget {
  const ConverterLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ConverterData.of(context);
    final color = data.state.color;
    final selection = ColorSelection.fromColor(color);
    final namingData = NamingData.of(context);
    final localization = Localization.of(context).converter;
    return Scaffold(
      appBar: AppBar(
        title: NamingCrossFadeText(defaultText: localization.colorConverter),
      ),
      body: ConverterBodyLayout(
        background: SwipingColorContainer(
          color: color,
          onColorSwipedVertical: data.onColorSwipedVertical,
          onColorSwipedHorizontal: data.onColorSwipedHorizontal,
          onColorSwipeEnd: () => namingData.onSelectionEnd(selection),
          onColorSwipeStart: () => namingData.onSelectionStart(selection),
        ),
      ),
    );
  }
}
