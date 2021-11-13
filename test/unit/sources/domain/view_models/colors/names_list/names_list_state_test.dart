import 'package:colored/sources/data/pagination/page_info.dart';
import 'package:colored/sources/domain/data_models/named_color.dart';
import 'package:colored/sources/domain/view_models/colors/names_list/names_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/hash.dart';

void main() {
  const testNamedColor = NamedColor(name: "Test", hex: "#000000");

  const testSearch = "test";

  const testPageInfo = PageInfo(startIndex: 1, size: 1, pageIndex: 1);

  group("Given a $Found state", () {
    group("when hashCode is called", () {
      test("then the palettes, search, and pageInfo are processed", () {
        final namedColors = [testNamedColor];
        final foundState = Found(
          namedColors,
          search: testSearch,
          pageInfo: testPageInfo,
        );
        expect(
          foundState.hashCode,
          hashObjects([namedColors, testSearch, testPageInfo]),
        );
      });
    });
  });

  group("Given two $Found state", () {
    group("when they differ on the named colors", () {
      test("then they are not equal", () {
        const otherNamedColor = NamedColor(name: "Test", hex: "#000001");
        const firstFoundState = Found(
          [testNamedColor, otherNamedColor],
          search: testSearch,
          pageInfo: testPageInfo,
        );
        const secondFoundState = Found(
          [otherNamedColor, testNamedColor],
          search: testSearch,
          pageInfo: testPageInfo,
        );
        expect(firstFoundState != secondFoundState, isTrue);
      });
    });

    group("when they differ on the searchString", () {
      test("then they are not equal", () {
        const firstFoundState = Found(
          [testNamedColor],
          search: testSearch,
          pageInfo: testPageInfo,
        );
        const secondFoundState = Found(
          [testNamedColor],
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
          [testNamedColor],
          search: testSearch,
          pageInfo: testPageInfo,
        );
        const secondFoundState = Found(
          [testNamedColor],
          search: testSearch,
          pageInfo: otherPageInfo,
        );
        expect(firstFoundState != secondFoundState, isTrue);
      });
    });
  });
}
