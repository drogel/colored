import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_switcher.dart';
import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_switcher_state.dart';
import 'package:colored/sources/presentation/widgets/animations/default_animated_switcher.dart';
import 'package:flutter/material.dart';

class CrossAnimatedSwitcher extends CrossSwitcher {
  const CrossAnimatedSwitcher({
    required Widget firstChild,
    required Widget secondChild,
    required CrossSwitcherState state,
    Key? key,
  }) : super(
          firstChild: firstChild,
          secondChild: secondChild,
          state: state,
          key: key,
        );

  @override
  Widget build(BuildContext context) => DefaultAnimatedSwitcher(
        child: state == CrossSwitcherState.showFirst ? firstChild : secondChild,
      );
}
