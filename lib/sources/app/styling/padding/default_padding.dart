import 'package:colored/sources/app/styling/padding/padding_scheme.dart';
import 'package:colored/sources/app/styling/padding/padding_constants.dart'
    as padding;
import 'package:flutter/material.dart';

class DefaultPadding implements PaddingScheme {
  const DefaultPadding();

  @override
  double get base => padding.base;

  @override
  EdgeInsets get medium => padding.medium;

  @override
  EdgeInsets get small => padding.small;

  @override
  EdgeInsets get vertical => padding.vertical;
}
