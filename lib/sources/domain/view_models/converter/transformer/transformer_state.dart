import 'package:colored/sources/domain/data_models/color_selection.dart';

class TransformerState {
  const TransformerState(this.selection);

  final ColorSelection selection;

  @override
  bool operator ==(Object other) =>
      other is TransformerState && selection == other.selection;

  @override
  int get hashCode => selection.hashCode;
}

class SelectionStarted extends TransformerState {
  const SelectionStarted(ColorSelection selection) : super(selection);
}

class SelectionEnded extends TransformerState {
  const SelectionEnded(ColorSelection selection) : super(selection);
}
