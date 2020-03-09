import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/data_models/color_format.dart';
import 'package:colored/sources/styling/colors.dart' as colors;
import 'package:colored/sources/styling/opacities.dart' as opacities;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kBorderRadius = 8.0;

class ClipboardButton extends StatefulWidget {
  const ClipboardButton({
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
        child: Text(widget.content, style: textStyle),
      ),
    );
  }

  Future<void> _getClipboardData() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    final isError = widget.clipboardShouldFail(
      clipboardData.text,
      widget.format,
    );
    if (isError) {
      setState(() {
        _tooltipMessage = Localization.of(context).tooltipError;
        _tooltipColor = colors.error;
      });
      _showTooltip();
    } else {
      widget.onClipboardRetrieved(clipboardData.text, widget.format);
    }
  }

  Future<void> _setTitleInClipboardData() async {
    await Clipboard.setData(ClipboardData(text: widget.content));
    setState(() {
      _tooltipMessage = Localization.of(context).tooltipMessage;
      _tooltipColor = colors.primaryDark;
    });
    _showTooltip();
  }

  void _showTooltip() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dynamic tooltipState = _tooltip.currentState;
      tooltipState.ensureTooltipVisible();
    });
  }
}
