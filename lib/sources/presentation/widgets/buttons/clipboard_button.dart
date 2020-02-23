import 'package:colored/sources/styling/colors.dart' as colors;
import 'package:colored/sources/styling/opacities.dart' as opacities;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardButton extends StatelessWidget {
  ClipboardButton({
    @required this.title,
    @required this.onClipboardRetrieved,
    @required this.onClipboardSet,
    Key key,
  }) : super(key: key);

  final String title;
  final void Function(String) onClipboardRetrieved;
  final void Function(String) onClipboardSet;
  final GlobalKey tooltip = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.title;

    return Tooltip(
      key: tooltip,
      message: "Copied!",
      preferBelow: false,
      child: RaisedButton(
        onPressed: _getClipboardData,
        onLongPress: _setTitleInClipboardData,
        highlightColor: colors.secondaryDark.withOpacity(opacities.shadow),
        splashColor: colors.secondary.withOpacity(opacities.fadedColor),
        color: colors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(title, style: textStyle),
      ),
    );
  }

  Future<void> _getClipboardData() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    onClipboardRetrieved(clipboardData.text);
  }

  Future<void> _setTitleInClipboardData() async {
    await Clipboard.setData(ClipboardData(text: title));
    final dynamic tooltipState = tooltip.currentState;
    tooltipState.ensureTooltipVisible();
    onClipboardSet(title);
  }
}
