import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/view_models/lists/palettes_list/palettes_list_data.dart';
import 'package:colored/sources/presentation/widgets/text_fields/search_field.dart';
import 'package:flutter/material.dart';

class PaletteSearchField extends StatefulWidget {
  const PaletteSearchField({Key key}) : super(key: key);

  @override
  _PaletteSearchFieldState createState() => _PaletteSearchFieldState();
}

class _PaletteSearchFieldState extends State<PaletteSearchField> {
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
    final data = PalettesListData.of(context);
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
    final data = PalettesListData.of(context);
    final localization = Localization.of(context).palettes;
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
