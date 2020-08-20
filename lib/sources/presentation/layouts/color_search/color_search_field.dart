import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/domain/view_models/lists/names_list/names_list_data.dart';
import 'package:colored/sources/presentation/widgets/buttons/plain_icon_button.dart';
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
    final theme = Theme.of(context);
    final radii = RadiusData.of(context).radiiScheme;
    final borderRadius = BorderRadius.all(radii.medium);
    final padding = PaddingData.of(context).paddingScheme;
    return Theme(
      data: theme.copyWith(canvasColor: theme.colorScheme.primaryVariant),
      child: Material(
        borderRadius: borderRadius,
        elevation: theme.appBarTheme.elevation,
        child: TextField(
          controller: _controller,
          style: theme.textTheme.headline6,
          focusNode: _focusNode,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: localization.search,
            contentPadding: EdgeInsets.only(left: padding.large.left),
            filled: true,
            fillColor: theme.colorScheme.primaryVariant,
            suffixIcon: PlainIconButton(
              icon: const Icon(Icons.clear),
              onPressed:
                  _controller.text.isEmpty ? null : () => _onClearPressed(data),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                style: BorderStyle.none,
                width: 0,
              ),
              borderRadius: borderRadius,
            ),
          ),
          onChanged: data.onSearchChanged,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onClearPressed(NamesListData data) {
    _controller.clear();
    data.onSearchChanged(_controller.text);
  }
}
