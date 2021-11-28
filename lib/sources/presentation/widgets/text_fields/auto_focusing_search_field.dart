import 'package:colored/sources/presentation/widgets/text_fields/search_field.dart';
import 'package:flutter/material.dart';

class AutoFocusingSearchField extends StatefulWidget {
  const AutoFocusingSearchField({
    required this.searchText,
    this.onClearPressed,
    this.onSubmitted,
    this.onChanged,
    this.hintText,
    this.focusNode,
    this.controller,
    Key? key,
  }) : super(key: key);

  final String searchText;
  final String? hintText;
  final void Function()? onClearPressed;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  @override
  _AutoFocusingSearchFieldState createState() =>
      _AutoFocusingSearchFieldState();
}

class _AutoFocusingSearchFieldState extends State<AutoFocusingSearchField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AutoFocusingSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    _shouldRequestFocus(widget.searchText);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => SearchField(
        hintText: widget.hintText,
        controller: _controller,
        focusNode: _focusNode,
        onClearPressed: widget.onClearPressed,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
      );

  void _shouldRequestFocus(String search) {
    if (search.isEmpty) {
      _focusNode.requestFocus();
    }
  }
}
