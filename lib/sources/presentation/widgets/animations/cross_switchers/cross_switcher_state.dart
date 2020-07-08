enum CrossSwitcherState {
  showFirst,
  showSecond,
}

extension SwitchableState on CrossSwitcherState {
  CrossSwitcherState switched() => this == CrossSwitcherState.showFirst
      ? CrossSwitcherState.showSecond
      : CrossSwitcherState.showFirst;
}
