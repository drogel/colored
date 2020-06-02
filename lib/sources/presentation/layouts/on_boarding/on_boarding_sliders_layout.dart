import 'package:auto_size_text/auto_size_text.dart';
import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_data.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_body_layout.dart';
import 'package:colored/sources/presentation/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

const _kInfoPixelRatio = 2.0;

class OnBoardingSlidersLayout extends StatelessWidget {
  const OnBoardingSlidersLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localization = Localization.of(context).onBoarding;
    final stateColor = ConverterData.of(context).state.color;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final padding = PaddingData.of(context).paddingScheme;
    return OnBoardingBodyLayout(
      children: <Widget>[
        if (pixelRatio >= _kInfoPixelRatio) SizedBox(height: padding.base),
        Flexible(
          flex: 4,
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
              if (pixelRatio >= _kInfoPixelRatio)
                Column(
                  children: <Widget>[
                    SizedBox(height: padding.base),
                    AutoSizeText(
                      localization.useSlidersFooter,
                      maxLines: 2,
                      style: textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: padding.base),
                  ],
                ),
              PrimaryButton(
                title: localization.done,
                onPressed: OnBoardingData.of(context).onFinished,
                backgroundColor: stateColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 2 * padding.base,
                  vertical: padding.medium.top,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(),
        ),
      ],
    );
  }
}
