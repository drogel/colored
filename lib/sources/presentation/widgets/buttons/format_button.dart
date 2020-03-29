import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/styling/radii.dart' as radii;
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/app/styling/colors.dart' as colors;
import 'package:colored/sources/presentation/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormatButton extends StatefulWidget {
  const FormatButton({
    @required this.content,
    @required this.format,
    @required this.onClipboardRetrieved,
    @required this.clipboardShouldFail,
    Key key,
  }) : super(key: key);

  final String content;
  final void Function(String, Format) onClipboardRetrieved;
  final bool Function(String, Format) clipboardShouldFail;
  final Format format;

  @override
  _FormatButtonState createState() => _FormatButtonState();
}

class _FormatButtonState extends State<FormatButton> {
  final GlobalKey _tooltip = GlobalKey();
  String _tooltipMessage;
  Color _tooltipColor;

  @override
  void initState() {
    _tooltipColor = colors.primaryVariant;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context).converter;
    return Tooltip(
      key: _tooltip,
      message: _tooltipMessage ?? localization.tooltipMessage,
      decoration: BoxDecoration(
        color: _tooltipColor,
        borderRadius: BorderRadius.circular(radii.small),
      ),
      preferBelow: false,
      child: PrimaryButton(
        onPressed: _getClipboardData,
        onLongPress: _setTitleInClipboardData,
        title: widget.content,
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
        _tooltipMessage = Localization.of(context).converter.tooltipError;
        _tooltipColor = colors.errorDark;
      });
      _showTooltip();
    } else {
      widget.onClipboardRetrieved(clipboardData.text, widget.format);
    }
  }

  Future<void> _setTitleInClipboardData() async {
    await Clipboard.setData(ClipboardData(text: widget.content));
    setState(() {
      _tooltipMessage = Localization.of(context).converter.tooltipMessage;
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