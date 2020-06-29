import 'package:colored/sources/domain/view_models/names_list/names_list_data.dart';
import 'package:colored/sources/presentation/layouts/color_suggestions/color_suggestions_layout.dart';
import 'package:colored/sources/presentation/layouts/names_list/color_names_search_field.dart';
import 'package:colored/sources/presentation/widgets/buttons/plain_icon_button.dart';
import 'package:flutter/material.dart';

class ColorNamesAppBar extends StatelessWidget {
  const ColorNamesAppBar({this.onBackPressed, Key key}) : super(key: key);

  final void Function() onBackPressed;

  @override
  Widget build(BuildContext context) {
    final data = NamesListData.of(context);
    return AppBar(
      title: ColorNamesSearchField(
        prefixIcon: PlainIconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _onBackPressed(data),
        ),
      ),
      centerTitle: true,
      flexibleSpace: Align(
        alignment: Alignment.bottomCenter,
        child: ColorSuggestionsLayout(
          onSuggestionSelected: data.onSearchChanged
        ),
      ),
    );
  }

  void _onBackPressed(NamesListData data) {
    data.onBackPressed();
    onBackPressed();
  }
}
