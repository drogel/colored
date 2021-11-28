import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/search/palette_suggestions_search_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_state.dart';
import 'package:colored/sources/presentation/widgets/text_fields/autocomplete_search_field.dart';
import 'package:flutter/material.dart';

class PaletteSearchField extends StatelessWidget {
  const PaletteSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = PalettesListData.of(context)!;
    final suggestionsData = PaletteSuggestionsSearchData.of(context)!;
    final localization = Localization.of(context)!.palettes;
    return AutocompleteSearchField(
      autocompleteOptions: _buildSuggestionsOptions(suggestionsData),
      hintText: localization.search,
      onClearPressed: data.onSearchCleared,
      onSubmitted: data.onSearchStarted,
      onChanged: suggestionsData.onSearchStarted,
      searchText: data.state.search,
    );
  }

  Iterable<Palette> _buildSuggestionsOptions(
    PaletteSuggestionsSearchData data,
  ) {
    final suggestionsState = data.state;
    switch (suggestionsState.runtimeType) {
      case Found:
        final foundState = suggestionsState as Found;
        return foundState.palettes;
      default:
        return [];
    }
  }
}
