import 'package:colored/sources/app/styling/padding/padding_scheme.dart';
import 'package:colored/sources/app/styling/padding/padding_constants.dart'
    as padding;
import 'package:flutter/material.dart';

class DefaultPaddingScheme implements PaddingScheme {
  const DefaultPaddingScheme();

  @override
  double get base => padding.base;

  @override
  EdgeInsets get large => padding.large;

  @override
  EdgeInsets get medium => padding.medium;

  @override
  EdgeInsets get small => padding.small;

  @override
  EdgeInsets get vertical => padding.list;
}
