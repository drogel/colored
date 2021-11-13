import 'dart:async';

import 'package:colored/sources/data/api/models/index/api_index.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_injector.dart';
import 'package:colored/sources/domain/view_models/base/names/base_names_view_model.dart';
import 'package:colored/sources/domain/view_models/base/names/names_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestPaginatedNamesService implements PaginatedNamesService<String> {
  const _TestPaginatedNamesService();

  @override
  Future<ListPage<String>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async =>
      null;
}

class _LocalViewModelMock extends BaseNamesListViewModel<String> {
  _LocalViewModelMock()
      : super(
          namesService: const _TestPaginatedNamesService(),
          stateController: StreamController<NamesListState>(),
        );

  @override
  NamesListState buildInitialState() => throw UnimplementedError();

  @override
  NamesListState buildSearchFailedState(String searchString) =>
      throw UnimplementedError();

  @override
  NamesListState buildSearchPendingState(String searchString) =>
      throw UnimplementedError();

  @override
  NamesListState buildSearchSuccessState(String searchString,
          {required PageInfo pageInfo, required List<String> items}) =>
      throw UnimplementedError();
}

class _ApiViewModelMock extends BaseNamesListViewModel<String> {
  _ApiViewModelMock()
      : super(
          namesService: const _TestPaginatedNamesService(),
          stateController: StreamController<NamesListState>(),
        );

  @override
  NamesListState buildInitialState() => throw UnimplementedError();

  @override
  NamesListState buildSearchFailedState(String searchString) =>
      throw UnimplementedError();

  @override
  NamesListState buildSearchPendingState(String searchString) =>
      throw UnimplementedError();

  @override
  NamesListState buildSearchSuccessState(String searchString,
          {required PageInfo pageInfo, required List<String> items}) =>
      throw UnimplementedError();
}

class _NamesInjectorStub extends BaseNamesInjector<String> {
  const _NamesInjectorStub({ApiIndex? apiIndex}) : super(apiIndex: apiIndex);

  @override
  BaseNamesListViewModel<String> injectApiViewModel(
    ApiIndex apiIndex, [
    StreamController<NamesListState>? stateController,
  ]) =>
      _ApiViewModelMock();

  @override
  BaseNamesListViewModel<String> injectLocalViewModel([
    StreamController<NamesListState>? stateController,
  ]) =>
      _LocalViewModelMock();
}

void main() {
  late NamesInjector<String> injector;

  group("Given a $BaseNamesInjector with a null $ApiIndex", () {
    setUp(() {
      injector = const _NamesInjectorStub(apiIndex: null);
    });

    group("when injectViewModel is called", () {
      test("then the local view model is retrieved", () {
        final viewModel = injector.injectViewModel();
        expect(viewModel, isA<_LocalViewModelMock>());
      });
    });
  });

  group("Given a $BaseNamesInjector with a non-null $ApiIndex", () {
    setUp(() {
      const apiIndexMock = ApiIndex(null, null, null);
      injector = const _NamesInjectorStub(apiIndex: apiIndexMock);
    });

    group("when injectViewModel is called", () {
      test("then the api view model is retrieved", () {
        final viewModel = injector.injectViewModel();
        expect(viewModel, isA<_ApiViewModelMock>());
      });
    });
  });
}
