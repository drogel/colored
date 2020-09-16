import 'package:flutter/material.dart';

class OnBoardingState {
  const OnBoardingState({
    @required this.pageScrollFraction,
  }) : assert(pageScrollFraction != null);

  final double pageScrollFraction;

  @override
  bool operator ==(Object other) =>
      other is OnBoardingState &&
      other.pageScrollFraction == pageScrollFraction;

  @override
  int get hashCode => pageScrollFraction.hashCode;
}
