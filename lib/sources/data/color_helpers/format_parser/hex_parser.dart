import 'dart:ui';

import 'package:colored/sources/common/factors.dart';
import 'package:colored/sources/data/color_helpers/format_parser/format_parser.dart';
import 'package:colored/sources/domain/data_models/color_selection.dart';

class HexParser extends FormatParser {
  final _hexRegExp = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

  @override
  bool hasMatch(String input) => _hexRegExp.hasMatch(input);

  @override
  ColorSelection parse(String string) {
    final buffer = StringBuffer();
    if (string.length == 6 || string.length == 7) {
      buffer.write('ff');
    }
    buffer.write(string.replaceFirst('#', ''));
    final color = Color(int.parse(buffer.toString(), radix: 16));
    final selection = ColorSelection(
      first: color.red / decimal8Bit,
      second: color.green / decimal8Bit,
      third: color.blue / decimal8Bit,
    );
    return selection;
  }
}
