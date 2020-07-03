import 'package:colored/sources/domain/data_models/color_selection.dart';
import 'package:vector_math/hash.dart';

class TransformerState {
  const TransformerState(this.selection);

  final ColorSelection selection;

  @override
  bool operator ==(Object other) =>
      other is TransformerState && selection == other.selection;

  @override
  int get hashCode => hashObjects([this, selection]);
}

class SelectionStarted extends TransformerState {
  const SelectionStarted(ColorSelection selection) : super(selection);

  @override
  bool operator ==(Object other) =>
      other is SelectionStarted && selection == other.selection;

  @override
  int get hashCode => hashObjects([this, selection]);
}

class SelectionEnded extends TransformerState {
  const SelectionEnded(ColorSelection selection) : super(selection);

  @override
  bool operator ==(Object other) =>
      other is SelectionEnded && selection == other.selection;

  @override
  int get hashCode => hashObjects([this, selection]);
}
