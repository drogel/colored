import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_data.dart';
import 'package:colored/sources/presentation/layouts/connectivity/connectivity_bar.dart';
import 'package:colored/sources/presentation/layouts/connectivity/connectivity_layout.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_app_bar.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_body_layout.dart';
import 'package:colored/sources/presentation/layouts/names_list/names_list_layout.dart';
import 'package:colored/sources/presentation/layouts/naming/naming_error_row.dart';
import 'package:colored/sources/presentation/layouts/transformer/transformer_layout.dart';
import 'package:colored/sources/presentation/widgets/animations/default_transition_switcher.dart';
import 'package:flutter/material.dart';

class ConverterLayout extends StatefulWidget {
  const ConverterLayout({Key key}) : super(key: key);

  @override
  _ConverterLayoutState createState() => _ConverterLayoutState();
}

class _ConverterLayoutState extends State<ConverterLayout> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ConverterAppBar(
          isSearching: isSearching,
          onSearchStateChange: _updateSearchingState,
        ),
        body: DefaultTransitionSwitcher(
          child: isSearching
              ? NamesListLayout(onColorCardPressed: _onColorCardPressed)
              : const ConnectivityLayout(
                  body: ConverterBodyLayout(background: TransformerLayout()),
                  child: ConnectivityBar(child: NamingErrorRow()),
                ),
        ),
      );

  void _updateSearchingState() => setState(() => isSearching = !isSearching);

  void _onColorCardPressed(Color color) {
    final selection = ColorSelection.fromColor(color);
    FocusScope.of(context).unfocus();
    TransformerData.of(context).onSelectionEnded(selection);
    _updateSearchingState();
  }
}
