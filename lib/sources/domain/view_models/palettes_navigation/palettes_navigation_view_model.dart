import 'dart:async';

import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_controller.dart';
import 'package:colored/sources/app/navigation/indexed_navigation/indexed_navigation_state.dart';
import 'package:flutter/foundation.dart';

class PalettesNavigationViewModel extends IndexedNavigationController {
  const PalettesNavigationViewModel({
    @required StreamController<IndexedNavigationState> stateController,
  }) : super(stateController: stateController);
}
