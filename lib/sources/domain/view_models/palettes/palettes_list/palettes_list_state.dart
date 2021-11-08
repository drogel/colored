import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/base/names/names_list_state.dart';

class Pending extends NamesListState {
  const Pending({required String search}) : super(search);

  factory Pending.emptySearch() => const Pending(search: "");
}

class Found extends NamesListState {
  const Found(this.palettes, {required String search}) : super(search);

  final List<Palette> palettes;
}

class NoneFound extends NamesListState {
  const NoneFound({required String search}) : super(search);
}
