import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/domain/view_models/palettes/palettes_list/palettes_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/hash.dart';

void main() {
  const testPalette = Palette(name: "Test", hexCodes: ["#000000", "#FFFFFF"]);

  const testSearch = "test";

  const testPageInfo = PageInfo(startIndex: 1, size: 1, pageIndex: 1);

  group("Given a $Found state", () {
    group("when hashCode is called", () {
      test("then the palettes, search, and pageInfo are processed", () {
        final palettes = [testPalette];
        final foundState = Found(
          palettes,
          search: testSearch,
          pageInfo: testPageInfo,
        );
        expect(
          foundState.hashCode,
          hashObjects([palettes, testSearch, testPageInfo]),
        );
      });
    });
  });

  group("Given two $Found state", () {
    group("when they differ on the palettes", () {
      test("then they are not equal", () {
        const otherPalette = Palette(
          name: "Test",
          hexCodes: ["#000001", "#FFFFFF"],
        );
        const firstFoundState = Found(
          [testPalette, otherPalette],
          search: testSearch,
          pageInfo: testPageInfo,
        );
        const secondFoundState = Found(
          [otherPalette, testPalette],
          search: testSearch,
          pageInfo: testPageInfo,
        );
        expect(firstFoundState != secondFoundState, isTrue);
      });
    });

    group("when they differ on the searchString", () {
      test("then they are not equal", () {
        const firstFoundState = Found(
          [testPalette],
          search: testSearch,
          pageInfo: testPageInfo,
        );
        const secondFoundState = Found(
          [testPalette],
          search: "notTestSearch",
          pageInfo: testPageInfo,
        );
        expect(firstFoundState != secondFoundState, isTrue);
      });
    });

    group("when they differ on the pageInfo", () {
      test("then they are not equal", () {
        const otherPageInfo = PageInfo(startIndex: 0, size: 2, pageIndex: 1);
        const firstFoundState = Found(
          [testPalette],
          search: testSearch,
          pageInfo: testPageInfo,
        );
        const secondFoundState = Found(
          [testPalette],
          search: testSearch,
          pageInfo: otherPageInfo,
        );
        expect(firstFoundState != secondFoundState, isTrue);
      });
    });
  });
}
