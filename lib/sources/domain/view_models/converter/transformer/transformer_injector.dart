import 'dart:async';
import 'dart:ui';

import 'package:colored/sources/data/color_helpers/transformer/color_transformer.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_state.dart';
import 'package:colored/sources/domain/view_models/converter/transformer/transformer_view_model.dart';
import 'package:flutter/foundation.dart';

class TransformerInjector {
  const TransformerInjector({@required Color initialColor})
      : assert(initialColor != null),
        _initialColor = initialColor;

  final Color _initialColor;

  TransformerViewModel injectViewModel([
    StreamController<TransformerState> stateController,
  ]) =>
      TransformerViewModel(
        stateController:
            stateController ?? StreamController<TransformerState>(),
        transformer: const ColorTransformer(),
        initialColor: _initialColor,
      );
}
