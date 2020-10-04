import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/presentation/widgets/chips/color_chip.dart';
import 'package:colored/sources/presentation/widgets/layouts/horizontal_tab_bar_list.dart';
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
  Widget build(BuildContext context) => HorizontalTabBarList(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ColorChip(
            text: suggestion.name,
            colorHex: suggestion.hex,
            onPressed: onSuggestionSelected,
          );
        },
      );
}
