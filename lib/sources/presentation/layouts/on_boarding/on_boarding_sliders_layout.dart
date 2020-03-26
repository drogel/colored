import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_data.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_body_layout.dart';
import 'package:colored/sources/presentation/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:colored/sources/app/styling/padding.dart' as padding;

class OnBoardingSlidersLayout extends StatelessWidget {
  const OnBoardingSlidersLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localization = Localization.of(context).onBoarding;
    final stateColor = ConverterData.of(context).state.color;
    return OnBoardingBodyLayout(
      columnAlignment: MainAxisAlignment.start,
      children: <Widget>[
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            localization.useSliders,
            style: textTheme.display3,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          localization.useSlidersBody,
          style: textTheme.headline,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2 * padding.largeText),
        Text(
          localization.useSlidersFooter,
          style: textTheme.headline,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2 * padding.largeText),
        PrimaryButton(
          title: localization.done,
          onPressed: OnBoardingData.of(context).onFinished,
          backgroundColor: stateColor,
          padding: EdgeInsets.symmetric(
            horizontal: 2 * padding.largeText,
            vertical: padding.button.top,
          ),
        ),
      ],
    );
  }
}
