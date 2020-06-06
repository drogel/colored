import 'package:colored/sources/app/styling/colors/color_constants.dart'
    as colors;
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/common/extensions/color_multi_lerp.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_data.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_body_layout.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_buttons_layout.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_sliders_layout.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_welcome_layout.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const _kSlidersScrollFractionTrigger = 1.66;
const _kBackgroundColors = [
  colors.text,
  colors.logoBlue,
  colors.logoRed,
];

class OnBoardingLayout extends StatefulWidget {
  const OnBoardingLayout();

  @override
  _OnBoardingLayoutState createState() => _OnBoardingLayoutState();
}

class _OnBoardingLayoutState extends State<OnBoardingLayout> {
  final _scroll = PageController();
  double _scrollFraction = 0;
  bool _showSliders = false;

  @override
  void initState() {
    _scroll.addListener(_handleScroll);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _scrollFraction = OnBoardingData.of(context).state.pageScrollFraction;
    _showSliders = _scrollFraction > _kSlidersScrollFractionTrigger;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: MultiLerp.multiLerp(_kBackgroundColors, _scrollFraction),
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(padding.base),
              child: Align(
                alignment: Alignment.topCenter,
                child: SmoothPageIndicator(
                  effect: WormEffect(
                    activeDotColor: colorScheme.primary,
                    dotColor: colors.logoGray,
                  ),
                  controller: _scroll,
                  count: _kBackgroundColors.length,
                ),
              ),
            ),
            PageView(
              controller: _scroll,
              children: const <Widget>[
                OnBoardingWelcomeLayout(),
                OnBoardingButtonsLayout(),
                OnBoardingSlidersLayout(),
              ],
            ),
            FractionalTranslation(
              translation: Offset(0, 1.0 - _scrollFraction.clamp(0, 1)),
              child: ConverterBodyLayout(
                slidersShownIfSpaceAvailable: _showSliders,
                gesturesEnabledIfSpaceAvailable: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final data = OnBoardingData.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    data.onPageScroll(_scroll.position.pixels, screenWidth);
  }
}
