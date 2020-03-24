import 'package:colored/sources/app/navigation/flow_navigator.dart';
import 'package:colored/sources/app/navigation/on_boarding_navigator.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_data.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_injector.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_view_model.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({
    @required this.injector,
    @required this.child,
    Key key,
  })  : assert(injector != null),
        super(key: key);

  final Widget child;
  final OnBoardingInjector injector;

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  OnBoardingViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<OnBoardingState>(
        stream: _viewModel.stateStream,
        initialData: _viewModel.initialData,
        builder: (_, snapshot) => OnBoardingData(
          state: snapshot.data,
          onPageScroll: _viewModel.computeScrollFraction,
          onFinished: _onOnBoardingFinished,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _onOnBoardingFinished() =>
      FlowNavigator.of(context).pushNamed(OnBoardingNavigator.converterFlow);
}
