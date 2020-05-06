import 'package:auto_size_text/auto_size_text.dart';
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
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return OnBoardingBodyLayout(
      children: <Widget>[
        if (devicePixelRatio > 2.5) const SizedBox(height: padding.largeText),
        Flexible(
          child: Column(
            children: <Widget>[
              AutoSizeText(
                localization.useSliders,
                maxLines: 1,
                style: textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              AutoSizeText(
                localization.useSlidersBody,
                maxLines: 2,
                style: textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              if (devicePixelRatio > 2.5)
                Column(
                  children: <Widget>[
                    const SizedBox(height: padding.largeText),
                    AutoSizeText(
                      localization.useSlidersFooter,
                      maxLines: 2,
                      style: textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: padding.largeText),
                  ],
                ),
              const SizedBox(height: padding.largeText / 2),
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
          ),
        ),
        Flexible(
          child: Container(),
        ),
      ],
    );
  }
}
