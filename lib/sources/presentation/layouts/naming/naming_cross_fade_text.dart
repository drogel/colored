import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_data.dart';
import 'package:colored/sources/domain/view_models/connectivity/connectivity_state.dart';
import 'package:colored/sources/domain/view_models/naming/naming_data.dart';
import 'package:colored/sources/domain/view_models/naming/naming_state.dart';
import 'package:flutter/material.dart';

class NamingCrossFadeText extends StatelessWidget {
  const NamingCrossFadeText({@required this.defaultText, Key key})
      : assert(defaultText != null),
        super(key: key);

  final String defaultText;

  @override
  Widget build(BuildContext context) {
    final state = NamingData.of(context).state;
    final connectivityState = ConnectivityData.of(context).state;
    final durations = DurationData.of(context).durationScheme;
    final curves = CurveData.of(context).curveScheme;
    return AnimatedSwitcher(
      switchInCurve: curves.incoming,
      switchOutCurve: curves.exiting,
      duration: durations.shortPresenting,
      reverseDuration: durations.shortDismissing,
      child: _buildText(state, connectivityState),
    );
  }

  Widget _buildText(NamingState state, ConnectivityState connectivityState) {
    final defaultTextWidget = Text(defaultText);
    if (connectivityState is NoConnection) {
      return defaultTextWidget;
    } else {
      switch (state.runtimeType) {
        case Changing:
          return const Text("");
        case Named:
          final name = (state as Named).name;
          return Text(name, key: Key(name));
        default:
          return defaultTextWidget;
      }
    }
  }
}
