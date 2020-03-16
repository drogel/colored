extension NonAlphanumericReplacement on String {
  String replacingAllNonAlphanumericBy(String replacement) =>
      replaceAll("[^A-Za-z0-9]", replacement);
}
