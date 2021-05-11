import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/presentation/widgets/chips/gradient_chip.dart';
import 'package:colored/sources/presentation/widgets/lists/horizontal_tab_bar_list.dart';
import 'package:flutter/material.dart';

class PaletteSuggestionsList extends StatelessWidget {
  const PaletteSuggestionsList({
    required this.suggestions,
    this.onSuggestionSelected,
    Key? key,
  }) : super(key: key);

  final List<Palette> suggestions;
  final void Function(String)? onSuggestionSelected;

  @override
  Widget build(BuildContext context) => HorizontalTabBarList(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return GradientChip(
            text: suggestion.name,
            hexCodes: suggestion.hexCodes,
            onPressed: onSuggestionSelected,
          );
        },
      );
}
