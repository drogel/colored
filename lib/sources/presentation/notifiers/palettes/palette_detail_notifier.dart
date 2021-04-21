import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_data.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_injector.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_state.dart';
import 'package:colored/sources/domain/view_models/palettes/palette_detail/palette_detail_view_model.dart';
import 'package:flutter/material.dart';

class PaletteDetailNotifier extends StatefulWidget {
  const PaletteDetailNotifier({
    required this.injector,
    required this.child,
    Key? key,
  })  : assert(injector != null),
        assert(child != null),
        super(key: key);

  final PaletteDetailInjector injector;
  final Widget child;

  @override
  _PaletteDetailNotifierState createState() => _PaletteDetailNotifierState();
}

class _PaletteDetailNotifierState extends State<PaletteDetailNotifier> {
  late PaletteDetailViewModel _viewModel;

  @override
  void initState() {
    _viewModel = widget.injector.injectViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<PaletteDetailState>(
        initialData: _viewModel.initialState,
        stream: _viewModel.stateStream,
        builder: (context, snapshot) => PaletteDetailData(
          state: snapshot.data!,
          onPaletteSelected: _viewModel.fetchColorNames,
          child: widget.child,
        ),
      );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
