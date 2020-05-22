import 'package:animations/animations.dart';
import 'package:colored/sources/app/styling/durations.dart' as durations;
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_app_bar.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_body_layout.dart';
import 'package:colored/sources/presentation/layouts/names_list/names_list_layout.dart';
import 'package:colored/sources/presentation/widgets/containers/swiping_color_container.dart';
import 'package:flutter/material.dart';

class ConverterLayout extends StatefulWidget {
  const ConverterLayout({Key key}) : super(key: key);

  @override
  _ConverterLayoutState createState() => _ConverterLayoutState();
}

class _ConverterLayoutState extends State<ConverterLayout> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final data = ConverterData.of(context);
    final selection = data.state.selection;
    return Scaffold(
      appBar: ConverterAppBar(
        isSearching: isSearching,
        onSearchStateChange: _updateSearchingState,
      ),
      body: PageTransitionSwitcher(
        duration: durations.longPresenting,
        transitionBuilder: _buildPageTransition,
        child: isSearching
            ? const NamesListLayout()
            : ConverterBodyLayout(
                background: SwipingColorContainer(
                  color: data.state.color,
                  onColorSwipedVertical: data.onColorSwipedVertical,
                  onColorSwipedHorizontal: data.onColorSwipedHorizontal,
                  onColorSwipeEnd: () => data.onSelectionEnd(selection),
                ),
              ),
      ),
    );
  }

  Widget _buildPageTransition(
    Widget child,
    Animation<double> primaryAnimation,
    Animation<double> secondaryAnimation,
  ) =>
      Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
      );

  void _updateSearchingState() => setState(() => isSearching = !isSearching);
}
