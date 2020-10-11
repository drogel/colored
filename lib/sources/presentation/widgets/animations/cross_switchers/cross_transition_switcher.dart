import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_switcher.dart';
import 'package:colored/sources/presentation/widgets/animations/cross_switchers/cross_switcher_state.dart';
import 'package:colored/sources/presentation/widgets/animations/transition_switcher.dart';
import 'package:flutter/material.dart';

class CrossTransitionSwitcher extends CrossSwitcher {
  const CrossTransitionSwitcher({
    @required Widget firstChild,
    @required Widget secondChild,
    @required CrossSwitcherState state,
    Key key,
  })  : assert(firstChild != null),
        assert(secondChild != null),
        assert(state != null),
        super(
          firstChild: firstChild,
          secondChild: secondChild,
          state: state,
          key: key,
        );

  @override
  Widget build(BuildContext context) => TransitionSwitcher(
        child: state == CrossSwitcherState.showFirst ? firstChild : secondChild,
      );
}
