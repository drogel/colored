import 'package:flutter/foundation.dart';

class PalettesListState {
  const PalettesListState(this.search);

  final String search;
}

class Pending extends PalettesListState {
  const Pending({@required String search}) : super(search);

  factory Pending.emptySearch() => const Pending(search: "");
}
