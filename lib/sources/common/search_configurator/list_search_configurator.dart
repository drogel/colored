import 'package:colored/sources/common/extensions/string_replace_non_alphanumeric.dart';
import 'package:colored/sources/common/search_configurator/search_configurator.dart';

class ListSearchConfigurator implements SearchConfigurator {
  const ListSearchConfigurator();

  @override
  String cleanSearch(String searchString) => searchString
      .trimLeft()
      .replacingAllNonAlphanumericBy("")
      .replaceAll("#", "");

  @override
  int get minSearchLength => 3;
}
