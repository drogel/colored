import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_switcher_state.dart';
import 'package:flutter/material.dart';

abstract class CrossSwitcher extends StatelessWidget {
  const CrossSwitcher({
    required this.firstChild,
    required this.secondChild,
    required this.state,
    Key? key,
  }) : super(key: key);

  final Widget firstChild;
  final Widget secondChild;
  final CrossSwitcherState state;
}
