import 'package:colored/sources/presentation/layouts/converter/converter_body_layout.dart';
import 'package:flutter/material.dart';

class OnBoardingButtonsLayout extends StatelessWidget {
  const OnBoardingButtonsLayout({
    @required this.scrolledFraction,
    Key key,
  }) : super(key: key);

  final double scrolledFraction;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(height: MediaQuery.of(context).size.height),
          FractionalTranslation(
            translation: Offset(0, 1 - scrolledFraction),
            child: const ConverterBodyLayout(
              initiallyShowSliders: false,
            ),
          ),
        ],
      );
}
