import 'package:animations/animations.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/presentation/layouts/connectivity/connectivity_bar.dart';
import 'package:colored/sources/presentation/layouts/connectivity/connectivity_layout.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_app_bar.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_body_layout.dart';
import 'package:colored/sources/presentation/layouts/names_list/names_list_layout.dart';
import 'package:colored/sources/presentation/layouts/naming/naming_error_row.dart';
import 'package:colored/sources/presentation/widgets/containers/swiping_color_container.dart';
import 'package:colored/sources/presentation/widgets/pickers/hue_picker/hsv_picker.dart';
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
    final durations = DurationData.of(context).durationScheme;
    final selection = data.state.selection;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ConverterAppBar(
        isSearching: isSearching,
        onSearchStateChange: _updateSearchingState,
      ),
      body: PageTransitionSwitcher(
        duration: durations.longPresenting,
        transitionBuilder: _buildPageTransition,
        child: isSearching
            ? NamesListLayout(onColorCardPressed: _onColorCardPressed)
            : ConnectivityLayout(
                body: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ConverterBodyLayout(
                      background: SwipingColorContainer(
                        color: data.state.color,
                        onColorSwipedVertical: data.onColorSwipedVertical,
                        onColorSwipedHorizontal: data.onColorSwipedHorizontal,
                        onColorSwipeEnd: () => data.onSelectionEnd(selection),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: HsvPicker(
                        color: data.state.color,
                        onChangeEnd: data.onSelectionEnd,
                        onChanged: data.onSelectionChanged,
                        onChangeStart: data.onSelectionStarted,
                      ),
                    ),
                  ],
                ),
                child: const ConnectivityBar(child: NamingErrorRow()),
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

  void _onColorCardPressed(Color color) {
    final selection = ColorSelection.fromColor(color);
    FocusScope.of(context).unfocus();
    ConverterData.of(context).onSelectionEnd(selection);
    _updateSearchingState();
  }
}
