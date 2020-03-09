import 'package:colored/sources/domain/data_models/color_format.dart';
import 'package:colored/sources/presentation/widgets/buttons/clipboard_button.dart';
import 'package:flutter/material.dart';

class TitledClipboardButton extends StatelessWidget {
  const TitledClipboardButton({
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
          Text(
            title,
            style: Theme.of(context).textTheme.subhead,
          ),
          const SizedBox(height: 8),
          ClipboardButton(
            format: format,
            clipboardShouldFail: clipboardShouldFail,
            onClipboardRetrieved: onClipboardRetrieved,
            content: content,
          ),
        ],
      );
}
