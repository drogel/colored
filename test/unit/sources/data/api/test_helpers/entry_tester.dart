import 'package:colored/sources/data/api/models/index/entries/api_index_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import 'api_index_entry_test_runner.dart';

abstract class EntryTester<T extends ApiIndexEntry> {
  const EntryTester(this.testRunner);

  final ApiIndexEntryTestRunner testRunner;

  Map<String, dynamic> get testMap;

  void assertExpectations(T entry);

  void assertChildEntryExpectations({
    required EntryTester entryTester,
    required ApiIndexEntry? entry,
  }) {
    if (entry != null) {
      entryTester.assertExpectations(entry);
    } else {
      fail("$ApiIndexEntry should not be null");
    }
  }
}
