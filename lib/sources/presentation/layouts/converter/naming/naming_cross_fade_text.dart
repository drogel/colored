import 'package:colored/sources/domain/view_models/converter/connectivity/connectivity_data.dart';
import 'package:colored/sources/domain/view_models/converter/connectivity/connectivity_state.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_data.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_state.dart';
import 'package:colored/sources/presentation/widgets/animations/default_animated_switcher.dart';
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
    return DefaultAnimatedSwitcher(
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
