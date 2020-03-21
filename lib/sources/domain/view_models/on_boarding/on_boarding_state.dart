import 'package:flutter/cupertino.dart';

class OnBoardingState {
  const OnBoardingState({
    @required this.pageScrollFraction,
  }) : assert(pageScrollFraction != null);

  final double pageScrollFraction;
}
