import 'dart:async';

import 'package:colored/sources/data/services/names/names_service.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_state.dart';
import 'package:colored/sources/domain/view_models/names_list/names_list_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNamesService extends Mock implements NamesService {}

class NamesServiceStub implements NamesService {
  static const Map<String, String> namesMap = {"testHex": "testName"};

  @override
  void dispose() {}

  @override
  Future<Map<String, String>> fetchNamesContaining(String searchString) async =>
      namesMap;

  @override
  Future<void> loadNames() async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  NamesListViewModel viewModel;
  StreamController<NamesListState> stateController;
  NamesService namesService;

  setUp(() {
    stateController = StreamController<NamesListState>();
    namesService = MockNamesService();
    viewModel = NamesListViewModel(
      stateController: stateController,
      namesService: namesService,
    );
  });

  tearDown(() {
    stateController = null;
    namesService = null;
  });

  group("When initialData is called", () {
    test("then a Busy state is received", () {
      final initialState = viewModel.initialData;
      expect(initialState.runtimeType, Busy);
    });
  });

  group("when init is called", () {
    test("then namesService is asked to load the names data", () {
      viewModel.init();
      verify(namesService.loadNames());
    });
  });

  group("when disponse is called", () {
    test("then namesService is asked to dispose", () {
      viewModel.dispose();
      verify(namesService.dispose());
    });
  });

  group("Given a NamesListViewModel with an stubbed NamesService", () {
    setUp(() {
      stateController = StreamController<NamesListState>();
      namesService = NamesServiceStub();
      viewModel = NamesListViewModel(
        stateController: stateController,
        namesService: namesService,
      );
    });

    tearDown(() {
      stateController.close();
      stateController = null;
      namesService = null;
    });

    group("when searchColorName is called", () {
      test("with a searchString of lenght < 3, then Busy state is added", () {
        stateController.stream.listen(
          (event) => expect(event.runtimeType, Busy),
        );
        viewModel.searchColorName("se");
      });

      test("with a searchString of lenght >= 3, then Found state is added", () {
        stateController.stream.listen(
          (event) => expect(event.runtimeType, Found),
        );
        viewModel.searchColorName("red");
      });

      test("with searchString.lenght >= 3, then namedColors are retrieved", () {
        stateController.stream.listen((event) {
          final found = event as Found;
          final expected = NamedColor(
            name: NamesServiceStub.namesMap.values.first,
            hex: "#${NamesServiceStub.namesMap.keys.first.toUpperCase()}",
          );
          final actual = found.namedColors.first;
          expect(actual, expected);
        });
        viewModel.searchColorName("red");
      });
    });
  });
}
