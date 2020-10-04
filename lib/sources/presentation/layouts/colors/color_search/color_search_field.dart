import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_data.dart';
import 'package:colored/sources/presentation/widgets/text_fields/search_field.dart';
import 'package:flutter/material.dart';

class ColorSearchField extends StatefulWidget {
  const ColorSearchField({Key key}) : super(key: key);

  @override
  _ColorSearchFieldState createState() => _ColorSearchFieldState();
}

class _ColorSearchFieldState extends State<ColorSearchField> {
  FocusNode _focusNode;
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final data = NamesListData.of(context);
    _controller.value = TextEditingValue(
      text: data.state.search,
      selection: TextSelection(
        baseOffset: data.state.search.length,
        extentOffset: data.state.search.length,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final data = NamesListData.of(context);
    final localization = Localization.of(context).namesList;
    return SearchField(
      hintText: localization.search,
      controller: _controller,
      focusNode: _focusNode,
      onClearPressed: () => data.onSearchChanged(_controller.text),
      onChanged: data.onSearchChanged,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
