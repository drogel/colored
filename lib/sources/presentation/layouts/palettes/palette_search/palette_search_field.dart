import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_data.dart';
import 'package:colored/sources/presentation/widgets/text_fields/auto_focusing_search_field.dart';
import 'package:flutter/material.dart';

class PaletteSearchField extends StatelessWidget {
  const PaletteSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = PalettesListData.of(context)!;
    final localization = Localization.of(context)!.palettes;
    return AutoFocusingSearchField(
      hintText: localization.search,
      onClearPressed: data.onSearchCleared,
      onSubmitted: data.onSearchStarted,
      searchText: data.state.search,
    );
  }
}
