import 'package:colored/sources/app/styling/radii/radii_scheme.dart';
import 'package:colored/sources/app/styling/radii/radius_constants.dart' as radii;
import 'package:flutter/material.dart';

class DefaultRadiiScheme implements RadiiScheme {
  const DefaultRadiiScheme();

  @override
  Radius get large => Radius.circular(radii.large);

  @override
  Radius get medium => Radius.circular(radii.medium);

  @override
  Radius get small => Radius.circular(radii.small);
}