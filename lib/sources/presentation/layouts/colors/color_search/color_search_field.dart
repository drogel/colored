import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/colors/color_suggestions/search/color_suggestions_search_data.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_data.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_state.dart';
import 'package:colored/sources/presentation/widgets/text_fields/autocomplete_search_field.dart';
import 'package:flutter/material.dart';

class ColorSearchField extends StatefulWidget {
  const ColorSearchField({Key? key}) : super(key: key);

  @override
  State<ColorSearchField> createState() => _ColorSearchFieldState();
}

class _ColorSearchFieldState extends State<ColorSearchField> {
  late Iterable<Palette> _palettes;

  @override
  void initState() {
    _palettes = [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final suggestionsData = ColorSuggestionsSearchData.of(context)!;
    _palettes = _buildSuggestionsOptions(suggestionsData);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final data = NamesListData.of(context)!;
    final suggestionsData = ColorSuggestionsSearchData.of(context)!;
    final localization = Localization.of(context)!.namesList;
    return AutocompleteSearchField(
      autocompleteOptions: _palettes,
      hintText: localization.search,
      onClearPressed: data.onSearchCleared,
      onSubmitted: data.onSearchStarted,
      onChanged: suggestionsData.onSearchStarted,
      searchText: data.state.search,
    );
  }

  Iterable<Palette> _buildSuggestionsOptions(ColorSuggestionsSearchData data) {
    final suggestionsState = data.state;
    switch (suggestionsState.runtimeType) {
      case NoneFound:
        return [];
      case Found:
        final foundState = suggestionsState as Found;
        return foundState.namedColors.map((c) => Palette.fromNamedColor(c));
      default:
        return _palettes;
    }
  }
}
