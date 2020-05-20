import 'package:colored/sources/domain/view_models/names_list/names_list_data.dart';
import 'package:flutter/material.dart';

class ColorNamesSearchField extends StatelessWidget {
  const ColorNamesSearchField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = NamesListData.of(context);
    return TextField(
      onChanged: data.onSearchChanged,
    );
  }
}