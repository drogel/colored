import 'dart:async';

import 'package:colored/sources/data/color_helpers/transformer/color_transformer.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_state.dart';
import 'package:colored/sources/domain/view_models/transformer/transformer_view_model.dart';

class TransformerInjector {
  const TransformerInjector();

  TransformerViewModel injectViewModel([
    StreamController<TransformerState> stateController,
  ]) =>
      TransformerViewModel(
        stateController:
            stateController ?? StreamController<TransformerState>(),
        transformer: const ColorTransformer(),
      );
}
