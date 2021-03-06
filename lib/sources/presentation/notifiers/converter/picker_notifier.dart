import 'package:colored/sources/domain/view_models/converter/picker/picker_data.dart';
import 'package:colored/sources/domain/view_models/converter/picker/picker_injector.dart';
import 'package:colored/sources/domain/view_models/converter/picker/picker_state.dart';
import 'package:colored/sources/domain/view_models/converter/picker/picker_view_model.dart';
import 'package:flutter/material.dart';

class PickerNotifier extends StatefulWidget {
  const PickerNotifier({
    required this.injector,
    required this.child,
    Key? key,
  }) : super(key: key);

  final PickerInjector injector;
  final Widget child;

  @override
  _PickerNotifierState createState() => _PickerNotifierState();
}

class _PickerNotifierState extends State<PickerNotifier> {
  late final PickerViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<PickerState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (_, snapshot) => PickerData(
          state: snapshot.data ?? _viewModel.initialState,
          onPickerSelected: _viewModel.updatePickerStyle,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
