import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_data.dart';
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
      backgroundColor: Color.lerp(
        colorScheme.onError,
        colorScheme.secondaryVariant,
        scrollFraction,
      ),
      body: PageView(
        controller: _scroll,
        children: <Widget>[
          const OnBoardingWelcomeLayout(),
          OnBoardingButtonsLayout(scrolledFraction: scrollFraction),
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
