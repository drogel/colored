import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/presentation/widgets/buttons/format_button.dart';
import 'package:flutter/material.dart';

class DropdownFormatButton extends StatelessWidget {
  const DropdownFormatButton({
    required this.title,
    required this.content,
    required this.format,
    required this.onClipboardRetrieved,
    required this.clipboardShouldFail,
    required this.onDropdownSelection,
    Key? key,
  }) : super(key: key);

  final String content;
  final void Function(String, Format) onClipboardRetrieved;
  final bool Function(String, Format) clipboardShouldFail;
  final void Function(Format, Format) onDropdownSelection;
  final Format format;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = PaddingData.of(context)!.paddingScheme;
    return Theme(
      data: theme.copyWith(canvasColor: theme.focusColor),
      child: Padding(
        padding: padding.small.add(EdgeInsets.only(top: padding.small.top)),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: format.rawValue,
              items: Format.values
                  .map((format) => DropdownMenuItem<String>(
                        value: format.rawValue,
                        child: Text(format.rawValue),
                      ))
                  .toList(),
              iconEnabledColor: Theme.of(context).colorScheme.secondary,
              underline: Container(),
              onChanged: _onDropdownSelectionChanged,
            ),
            FormatButton(
              format: format,
              clipboardShouldFail: clipboardShouldFail,
              onClipboardRetrieved: onClipboardRetrieved,
              content: content,
            ),
          ],
        ),
      ),
    );
  }

  void _onDropdownSelectionChanged(String? value) {
    if (value == null) {
      return;
    }
    onDropdownSelection(FormatValue.format(value), format);
  }
}
