import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/presentation/widgets/containers/color_chip.dart';
import 'package:flutter/material.dart';

class ColorSuggestionsList extends StatelessWidget {
  const ColorSuggestionsList({
    @required this.suggestions,
    this.onSuggestionSelected,
    Key key,
  }) : super(key: key);

  final List<NamedColor> suggestions;
  final void Function(String) onSuggestionSelected;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    final horizontalPadding = padding.small.horizontal;
    return SizedBox(
      height: kTextTabBarHeight,
      child: ListView.builder(
        padding: EdgeInsets.only(
          left: horizontalPadding,
          right: 2 * horizontalPadding,
        ),
        itemCount: suggestions.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ColorChip(
            text: suggestion.name,
            colorHex: suggestion.hex,
            onPressed: onSuggestionSelected,
          );
        },
      ),
    );
  }
}
