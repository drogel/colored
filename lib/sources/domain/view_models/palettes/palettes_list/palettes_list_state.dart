import 'package:collection/collection.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';

class Starting extends NamesListState {
  const Starting() : super("");
}

class Pending extends NamesListState {
  const Pending({required String search}) : super(search);
}

class Found extends NamesListState {
  const Found(
    this.palettes, {
    required String search,
    required this.pageInfo,
  }) : super(search);

  final List<Palette> palettes;
  final PageInfo pageInfo;

  @override
  bool operator ==(Object other) =>
      other is Found &&
      const ListEquality().equals(other.palettes, palettes) &&
      other.search == search &&
      other.pageInfo == pageInfo;

  @override
  int get hashCode => Object.hashAll([palettes, search, pageInfo]);
}

class NoneFound extends NamesListState {
  const NoneFound({required String search}) : super(search);
}
