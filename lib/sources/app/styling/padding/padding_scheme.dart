import 'package:flutter/material.dart';

abstract class PaddingScheme {
  double get base;

  EdgeInsets get large;

  EdgeInsets get medium;

  EdgeInsets get small;

  EdgeInsets get vertical;
}
