import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/presentation/widgets/buttons/primary_button.dart';
import 'package:colored/sources/presentation/widgets/containers/colored_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormatButton extends StatefulWidget {
  const FormatButton({
    required this.content,
    required this.format,
    required this.onClipboardRetrieved,
    required this.clipboardShouldFail,
    Key? key,
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
  late Color _tooltipColor;
  String? _tooltipMessage;

  @override
  void didChangeDependencies() {
    _tooltipColor = Theme.of(context).colorScheme.primaryContainer;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context)!.converter;
    return ColoredTooltip(
      tooltipKey: _tooltip,
      message: _tooltipMessage ?? localization.tooltipMessage,
      color: _tooltipColor,
      child: PrimaryButton(
        onPressed: _getClipboardData,
        onLongPress: _setTitleInClipboardData,
        title: widget.content,
      ),
    );
  }

  Future<void> _getClipboardData() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    final clipboardText = clipboardData?.text;
    if (clipboardText == null) {
      return;
    }
    final isError = widget.clipboardShouldFail(
      clipboardText,
      widget.format,
    );
    if (isError) {
      setState(() {
        _tooltipMessage = Localization.of(context)!.converter.tooltipError;
        _tooltipColor = Theme.of(context).colorScheme.error;
      });
      _showTooltip();
    } else {
      widget.onClipboardRetrieved(clipboardText, widget.format);
    }
  }

  Future<void> _setTitleInClipboardData() async {
    await Clipboard.setData(ClipboardData(text: widget.content));
    setState(() {
      _tooltipMessage = Localization.of(context)!.converter.tooltipMessage;
      _tooltipColor = Theme.of(context).colorScheme.secondaryContainer;
    });
    _showTooltip();
  }

  void _showTooltip() {
    HapticFeedback.mediumImpact();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final dynamic tooltipState = _tooltip.currentState;
      tooltipState.ensureTooltipVisible();
    });
  }
}
