import 'package:animations/animations.dart';
import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_body_layout.dart';
import 'package:colored/sources/presentation/layouts/names_list/color_names_search_field.dart';
import 'package:colored/sources/presentation/layouts/names_list/names_list_layout.dart';
import 'package:colored/sources/presentation/widgets/containers/swiping_color_container.dart';
import 'package:colored/sources/presentation/layouts/naming/naming_cross_fade_text.dart';
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
    final localization = Localization.of(context).converter;
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? const ColorNamesSearchField()
            : NamingCrossFadeText(defaultText: localization.colorConverter),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => setState(() => isSearching = !isSearching),
          )
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: _buildTransition,
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

  Widget _buildTransition(Widget child, Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation) =>
      FadeThroughTransition(
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
}
