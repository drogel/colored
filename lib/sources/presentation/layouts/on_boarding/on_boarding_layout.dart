import 'package:colored/sources/app/styling/colors.dart' as colors;
import 'package:colored/sources/common/extensions/color_multi_lerp.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_data.dart';
import 'package:colored/sources/presentation/layouts/converter/converter_body_layout.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_buttons_layout.dart';
import 'package:colored/sources/presentation/layouts/on_boarding/on_boarding_welcome_layout.dart';
import 'package:flutter/material.dart';

class OnBoardingLayout extends StatefulWidget {
  const OnBoardingLayout();

  @override
  _OnBoardingLayoutState createState() => _OnBoardingLayoutState();
}

class _OnBoardingLayoutState extends State<OnBoardingLayout>
    with ChangeNotifier {
  final _scroll = PageController();

  @override
  void didChangeDependencies() {
    if (!_scroll.hasListeners) {
      _scroll.addListener(_handleScroll);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scrollFraction = OnBoardingData.of(context).state.pageScrollFraction;
    return Scaffold(
      backgroundColor: MultiLerp.multiLerp(
        [
          colorScheme.onError,
          colors.logoBlue,
          colors.logoRed,
        ],
        scrollFraction,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            controller: _scroll,
            children: const <Widget>[
              OnBoardingWelcomeLayout(),
              OnBoardingButtonsLayout(),
              OnBoardingButtonsLayout(),
            ],
          ),
          FractionalTranslation(
            translation: Offset(0, 1 - scrollFraction),
            child: const ConverterBodyLayout(initiallyShowSliders: false),
          ),
        ],
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
