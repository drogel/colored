import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_data.dart';
import 'package:colored/sources/presentation/layouts/connectivity/connectivity_bar.dart';
import 'package:colored/sources/presentation/layouts/connectivity/connectivity_layout.dart';
import 'package:colored/sources/presentation/layouts/converter_page/converter_page_app_bar.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_layout.dart';
import 'package:colored/sources/presentation/layouts/names_list/names_list_layout.dart';
import 'package:colored/sources/presentation/layouts/naming/naming_error_row.dart';
import 'package:colored/sources/presentation/layouts/transformer/transformer_layout.dart';
import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_switcher_state.dart';
import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_transition_switcher.dart';
import 'package:flutter/material.dart';

class ConverterPageBody extends StatelessWidget {
  const ConverterPageBody({
    @required this.searchingState,
    @required this.onSearchStateChange,
    Key key,
  })  : assert(onSearchStateChange != null),
        assert(searchingState != null),
        super(key: key);

  final CrossSwitcherState searchingState;
  final void Function() onSearchStateChange;

  @override
  Widget build(BuildContext context) => CrossTransitionSwitcher(
        state: searchingState,
        firstChild: const ConnectivityLayout(
          body: ConverterLayout(background: TransformerLayout()),
          child: ConnectivityBar(child: NamingErrorRow()),
        ),
        secondChild: NamesListLayout(
          onColorCardPressed: (color) => _notifyColorSelected(context, color),
        ),
      );

  void _notifyColorSelected(BuildContext context, Color color) {
    final selection = ColorSelection.fromColor(color);
    FocusScope.of(context).unfocus();
    TransformerData.of(context).onSelectionEnded(selection);
    onSearchStateChange();
  }
}
