import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_data.dart';
import 'package:colored/sources/presentation/widgets/text_fields/auto_focusing_search_field.dart';
import 'package:flutter/material.dart';

class ColorSearchField extends StatelessWidget {
  const ColorSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = NamesListData.of(context)!;
    final localization = Localization.of(context)!.namesList;
    return AutoFocusingSearchField(
      hintText: localization.search,
      onClearPressed: data.onSearchCleared,
      onSubmitted: data.onSearchStarted,
      searchText: data.state.search,
    );
  }
}
