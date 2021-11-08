import 'dart:async';

import 'package:colored/sources/common/search_configurator/search_configurator.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_list_state.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_state.dart';

class NamesListViewModel extends BaseNamesListViewModel<NamedColor> {
  const NamesListViewModel({
    required StreamController<NamesListState> stateController,
    required PaginatedNamesService<NamedColor> namesService,
    required SearchConfigurator searchConfigurator,
  }) : super(
          stateController: stateController,
          namesService: namesService,
          searchConfigurator: searchConfigurator,
        );

  @override
  NamesListState buildInitialState() => Pending.emptySearch();

  @override
  NamesListState buildSearchFailedState(String searchString) =>
      NoneFound(search: searchString);

  @override
  NamesListState buildSearchPendingState(String searchString) =>
      Pending(search: searchString);

  @override
  NamesListState buildSearchSuccessState(
    String searchString, {
    required PageInfo pageInfo,
    required List<NamedColor> items,
  }) =>
      Found(items, search: searchString, pageInfo: pageInfo);
}
