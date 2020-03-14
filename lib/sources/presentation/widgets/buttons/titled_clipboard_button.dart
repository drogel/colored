import 'package:colored/sources/domain/data_models/color_format.dart';
import 'package:colored/sources/presentation/widgets/buttons/clipboard_button.dart';
import 'package:flutter/material.dart';

class DropdownFormatButton extends StatelessWidget {
  const DropdownFormatButton({
    @required this.title,
    @required this.content,
    @required this.format,
    @required this.onClipboardRetrieved,
    @required this.clipboardShouldFail,
    Key key,
  }) : super(key: key);

  final String content;
  final void Function(String, ColorFormat) onClipboardRetrieved;
  final bool Function(String, ColorFormat) clipboardShouldFail;
  final ColorFormat format;
  final String title;

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          DropdownButton<String>(
            value: format.value,
            items: ColorFormat.values
                .map(
                  (format) => DropdownMenuItem<String>(
                    value: format.value,
                    child: Text(format.value),
                  ),
                )
                .toList(),
            underline: Container(),
            isDense: true,
            onChanged: (_) {},
          ),
          const SizedBox(height: 8),
          FormatButton(
            format: format,
            clipboardShouldFail: clipboardShouldFail,
            onClipboardRetrieved: onClipboardRetrieved,
            content: content,
          ),
        ],
      );
}
