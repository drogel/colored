import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given an ConverterState", () {
    group("when constructed", () {
      test("then an error is thrown if formatData is null", () {
        expect(
          () => ConverterState(formatData: null),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group("when checking for equality", () {
      test("then two states are equal if formatDatas are equal", () {
        const firstState = ConverterState(formatData: {Format.hex: "#000000"});
        const secondState = ConverterState(formatData: {Format.hex: "#000000"});

        expect(firstState == secondState, isTrue);
      });

      test("then two states are not equal if formatDatas differ", () {
        const firstState = ConverterState(formatData: {Format.hex: "#000000"});
        const secondState = ConverterState(formatData: {Format.hex: "#121212"});

        expect(firstState == secondState, isFalse);
      });

      test("the hashCode is based on the formatData hashcode", () {
        const formatData = {Format.hex: "#121212"};
        const state = ConverterState(formatData: formatData);

        expect(state.hashCode, formatData.hashCode);
      });
    });

    group("when toString is called", () {
      test("the expected representation with the formatData is retrieved", () {
        const formatData = {Format.hex: "#121212"};
        const state = ConverterState(formatData: formatData);

        final actual = state.toString();

        expect(actual, "ConverterState(formatData: {Format.hex: #121212})");
      });
    });
  });
}
