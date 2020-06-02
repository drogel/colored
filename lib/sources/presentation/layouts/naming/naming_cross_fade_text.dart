import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/durations.dart' as durations;
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
    final curves = CurveData.of(context).curveScheme;
    return AnimatedSwitcher(
      switchInCurve: curves.incoming,
      switchOutCurve: curves.exiting,
      duration: durations.shortPresenting,
      reverseDuration: durations.shortDismissing,
      child: _buildText(state),
    );
  }

  Widget _buildText(NamingState state) {
    switch (state.runtimeType) {
      case Changing:
        return const Text("");
      case Named:
        final name = (state as Named).name;
        return Text(name, key: Key(name));
      default:
        return Text(defaultText);
    }
  }
}
