import 'package:colored/sources/app/navigation/routers/converter_router.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_data.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_injector.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_state.dart';
import 'package:colored/sources/domain/view_models/on_boarding/on_boarding_view_model.dart';
import 'package:flutter/material.dart';

class OnBoardingNotifier extends StatefulWidget {
  const OnBoardingNotifier({
    @required this.injector,
    @required this.child,
    Key key,
  })  : assert(injector != null),
        super(key: key);

  final Widget child;
  final OnBoardingInjector injector;

  @override
  _OnBoardingNotifierState createState() => _OnBoardingNotifierState();
}

class _OnBoardingNotifierState extends State<OnBoardingNotifier> {
  OnBoardingViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel()..init();
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

  Future<void> _onOnBoardingFinished() async {
    await _viewModel.onOnBoardingFinish();
    await Navigator.of(context).pushReplacementNamed(ConverterRouter.name);
  }
}
