import 'package:colored/sources/domain/data_models/main_tabs_selection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a MainTabsSelection", () {
    group("when rawValue called", () {
      test("then expected raw int value is retrieved", () {
        expect(MainTabsSelection.converter.rawValue, 0);
        expect(MainTabsSelection.colors.rawValue, 1);
      });
    });
  });

  group("Given a MainTabsSelectionBuilder", () {
    group("when fromRawValue called", () {
      test("then expected MainTabsSelection case is retrieved", () {
        final converterFromBuilder = MainTabsSelectionBuilder.fromRawValue(0);
        final colorsFromBuilder = MainTabsSelectionBuilder.fromRawValue(1);
        expect(converterFromBuilder, MainTabsSelection.converter);
        expect(colorsFromBuilder, MainTabsSelection.colors);
      });

      test("then null is retrieved if given a value with no selection", () {
        expect(MainTabsSelectionBuilder.fromRawValue(99), null);
      });
    });
  });
}
