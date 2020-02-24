import 'package:colored/sources/styling/colors.dart' as colors;
import 'package:colored/sources/styling/opacities.dart' as opacities;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kBorderRadius = 8.0;

class ClipboardButton extends StatefulWidget {
  const ClipboardButton({
    @required this.title,
    @required this.onClipboardRetrieved,
    @required this.onClipboardSet,
    @required this.clipboardShouldShowError,
    Key key,
  }) : super(key: key);

  final String title;
  final void Function(String) onClipboardRetrieved;
  final void Function(String) onClipboardSet;
  final bool Function(String) clipboardShouldShowError;

  @override
  _ClipboardButtonState createState() => _ClipboardButtonState();
}

class _ClipboardButtonState extends State<ClipboardButton> {
  final GlobalKey _tooltip = GlobalKey();
  String _tooltipMessage;
  Color _tooltipColor;

  @override
  void initState() {
    _tooltipColor = colors.primaryDark;
    _tooltipMessage = "Copied!";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.title;

    return Tooltip(
      key: _tooltip,
      message: _tooltipMessage,
      decoration: BoxDecoration(
        color: _tooltipColor,
        borderRadius: BorderRadius.circular(_kBorderRadius / 2),
      ),
      preferBelow: false,
      child: RaisedButton(
        onPressed: _getClipboardData,
        onLongPress: _setTitleInClipboardData,
        highlightColor: colors.secondaryDark.withOpacity(opacities.shadow),
        splashColor: colors.secondary.withOpacity(opacities.fadedColor),
        color: colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_kBorderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(widget.title, style: textStyle),
      ),
    );
  }



  Future<void> _getClipboardData() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    final isError = widget.clipboardShouldShowError(clipboardData.text);
    if (isError) {
      setState(() {
        _tooltipMessage = "Error!";
        _tooltipColor = colors.error;
      });
      _showTooltip();
    } else {
      widget.onClipboardRetrieved(clipboardData.text);
    }
  }

  Future<void> _setTitleInClipboardData() async {
    await Clipboard.setData(ClipboardData(text: widget.title));
    setState(() {
      _tooltipMessage = "Copied!";
      _tooltipColor = colors.primaryDark;
    });
    _showTooltip();
    widget.onClipboardSet(widget.title);
  }

  void _showTooltip() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dynamic tooltipState = _tooltip.currentState;
      tooltipState.ensureTooltipVisible();
    });
  }
}
