import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:flutter/foundation.dart';

class PalettesListState {
  const PalettesListState(this.search);

  final String search;
}

class Pending extends PalettesListState {
  const Pending({required String search}) : super(search);

  factory Pending.emptySearch() => const Pending(search: "");
}

class Found extends PalettesListState {
  const Found(this.palettes, {required String search}) : super(search);

  final List<Palette> palettes;
}

class NoneFound extends PalettesListState {
  const NoneFound({required String search}) : super(search);
}
