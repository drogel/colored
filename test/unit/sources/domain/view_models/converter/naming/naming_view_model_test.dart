import 'dart:async';

import 'package:colored/sources/data/color_helpers/converter/converter.dart';
import 'package:colored/sources/data/pagination/list_page.dart';
import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/data/services/connectivity/connectivity_service.dart';
import 'package:colored/sources/data/services/names/paginated_names_service.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_state.dart';
import 'package:colored/sources/domain/view_models/converter/naming/naming_view_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:connectivity_platform_interface/src/enums.dart';
import 'package:flutter_test/flutter_test.dart';

class NamingServiceSuccessStub implements PaginatedNamesService<NamedColor> {
  const NamingServiceSuccessStub();

  static const String name = "testColor";

  @override
  Future<ListPage<NamedColor>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async =>
      const ListPage<NamedColor>(
        currentItemCount: 1,
        itemsPerPage: 1,
        startIndex: 1,
        totalItems: 1,
        pageIndex: 1,
        totalPages: 1,
        items: [NamedColor(name: name, hex: "testHex")],
      );
}

class NamingServiceFailureStub implements PaginatedNamesService<NamedColor> {
  const NamingServiceFailureStub();

  @override
  Future<ListPage<NamedColor>?> fetchContainingSearch(
    String searchString, {
    required PageInfo pageInfo,
  }) async =>
      null;
}

class ConverterStub implements Converter {
  @override
  Map<Format, String> convert(int r, int g, int b) =>
      {Format.hex: "mockedConversion"};
}

class RgbConverterStub implements Converter {
  @override
  Map<Format, String> convert(int r, int g, int b) =>
      {Format.rgb: "mockedConversion"};
}

class ConnectivityServiceSuccessStub implements ConnectivityService {
  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      StreamController<ConnectivityResult>().stream;
}

void main() {
  late NamingViewModel viewModel;
  late StreamController<NamingState> stateController;
  late PaginatedNamesService<NamedColor> namingService;
  late Converter converter;

  group("Given a NamingViewModel with successful NamingService requests", () {
    setUp(() {
      stateController = StreamController<NamingState>();
      namingService = const NamingServiceSuccessStub();
      converter = ConverterStub();
      viewModel = NamingViewModel(
        stateController: stateController,
        namingService: namingService,
        converter: converter,
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when stateStream is called", () {
      test("the stream of the provided state controller is retrieved", () {
        expect(viewModel.stateStream, stateController.stream);
      });
    });

    group("when initialState is called", () {
      test("then an Unknown state is retrieved", () async {
        final initialState = viewModel.initialState;
        expect(initialState, isA<Unknown>());
      });
    });

    group("when dispose is called", () {
      test("then stateController is closed", () {
        expect(stateController.isClosed, false);
        viewModel.dispose();
        expect(stateController.isClosed, true);
      });
    });

    group("when fetchNaming is called", () {
      test("then a Changing state is added to the stream first", () async {
        final selection = ColorSelection(r: 0, g: 0, b: 0);
        await viewModel.fetchNaming(selection);
        final state = await stateController.stream.first;
        expect(state, isA<Changing>());
      });

      test("then a Named state is added to stream after Changing", () async {
        stateController.stream.skip(1).listen((event) {
          expectLater(event, isA<Named>());
        });
        final selection = ColorSelection(r: 0, g: 0, b: 0);
        await viewModel.fetchNaming(selection);
      });

      test("then a Named state with expected name is retrieved", () async {
        stateController.stream.skip(1).listen((event) {
          final name = (event as Named).name;
          expectLater(name, NamingServiceSuccessStub.name);
        });
        final selection = ColorSelection(r: 0, g: 0, b: 0);
        await viewModel.fetchNaming(selection);
      });
    });
  });

  group("Given a NamingViewModel with failing NamingService requests", () {
    setUp(() {
      stateController = StreamController<NamingState>();
      namingService = const NamingServiceFailureStub();
      converter = ConverterStub();
      viewModel = NamingViewModel(
        stateController: stateController,
        namingService: namingService,
        converter: converter,
      );
    });

    tearDown(() {
      stateController.close();
    });

    group("when initialState is called", () {
      test("then an Unknown state is retrieved", () async {
        final initialState = viewModel.initialState;
        expect(initialState, isA<Unknown>());
      });
    });

    group("when fetchNaming is called", () {
      test("then a Changing state is added to the stream first", () async {
        final selection = ColorSelection(r: 0, g: 0, b: 0);
        await viewModel.fetchNaming(selection);
        final state = await stateController.stream.first;
        expect(state, isA<Changing>());
      });

      test("then an Unknown state is added to stream after Changing", () async {
        stateController.stream.skip(1).listen((event) {
          expectLater(event, isA<Unknown>());
        });
        final selection = ColorSelection(r: 0, g: 0, b: 0);
        await viewModel.fetchNaming(selection);
      });
    });
  });

  group("Given a NamingViewModel with a failing converter", () {
    setUp(() {
      stateController = StreamController<NamingState>();
      namingService = const NamingServiceSuccessStub();
      converter = RgbConverterStub();
      viewModel = NamingViewModel(
        stateController: stateController,
        namingService: namingService,
        converter: converter,
      );
    });

    tearDown(() {
      stateController.close();
    });

    test("then a Unknown state is added to stream after Changing", () async {
      stateController.stream.skip(1).listen((event) {
        expectLater(event, isA<Unknown>());
      });
      final selection = ColorSelection(r: 0, g: 0, b: 0);
      await viewModel.fetchNaming(selection);
    });
  });
}
