import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';

class NamesListState {
  const NamesListState(this.search);

  final String search;
}

class Pending extends NamesListState {
  const Pending({required String search}) : super(search);

  factory Pending.emptySearch() => const Pending(search: "");
}

class Found extends NamesListState {
  const Found(
    this.namedColors, {
    required String search,
    required this.pageInfo,
  }) : super(search);

  final List<NamedColor> namedColors;
  final PageInfo pageInfo;
}

class NoneFound extends NamesListState {
  const NoneFound({required String search}) : super(search);
}
