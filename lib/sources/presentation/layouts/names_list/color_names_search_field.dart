import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_data.dart';
import 'package:flutter/material.dart';

class ColorNamesSearchField extends StatefulWidget {
  const ColorNamesSearchField({this.prefixIcon, Key key}) : super(key: key);

  final Widget prefixIcon;

  @override
  _ColorNamesSearchFieldState createState() => _ColorNamesSearchFieldState();
}

class _ColorNamesSearchFieldState extends State<ColorNamesSearchField> {
  FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = NamesListData.of(context);
    final localization = Localization.of(context).namesList;
    final theme = Theme.of(context);
    final radii = RadiusData.of(context).radiiScheme;
    final borderRadius = BorderRadius.all(radii.medium);
    return Material(
      borderRadius: borderRadius,
      elevation: theme.appBarTheme.elevation,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          TextField(
            style: theme.textTheme.headline6,
            focusNode: _focusNode,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: localization.search,
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: theme.colorScheme.primaryVariant,
              prefixIcon: widget.prefixIcon,
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
          widget.prefixIcon,
        ],
      ),
    );
  }
}
