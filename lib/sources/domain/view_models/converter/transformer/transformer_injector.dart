import 'dart:async';
import 'dart:ui';

import 'package:colored/sources/data/color_helpers/transformer/color_transformer.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_state.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_view_model.dart';

class TransformerInjector {
  const TransformerInjector({required Color initialColor})
      : _initialColor = initialColor;

  final Color _initialColor;

  TransformerViewModel injectViewModel([
    StreamController<TransformerState>? stateController,
  ]) =>
      TransformerViewModel(
        stateController:
            stateController ?? StreamController<TransformerState>(),
        transformer: const ColorTransformer(),
        initialColor: _initialColor,
      );
}
