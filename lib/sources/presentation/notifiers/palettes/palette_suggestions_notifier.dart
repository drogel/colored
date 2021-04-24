import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_injector.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_suggestions/palette_suggestions_view_model.dart';
import 'package:flutter/material.dart';

class PaletteSuggestionsNotifier extends StatefulWidget {
  const PaletteSuggestionsNotifier({
    required this.injector,
    required this.child,
    Key? key,
  }) : super(key: key);

  final PaletteSuggestionsInjector injector;
  final Widget child;

  @override
  _PaletteSuggestionsNotifierState createState() =>
      _PaletteSuggestionsNotifierState();
}

class _PaletteSuggestionsNotifierState
    extends State<PaletteSuggestionsNotifier> {
  late PaletteSuggestionsViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel()..init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<PaletteSuggestionsState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (_, snapshot) => PaletteSuggestionsData(
          state: snapshot.data ?? _viewModel.initialState,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
