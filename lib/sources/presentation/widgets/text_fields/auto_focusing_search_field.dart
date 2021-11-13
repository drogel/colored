import 'package:colored/sources/presentation/widgets/text_fields/search_field.dart';
import 'package:flutter/material.dart';

class AutoFocusingSearchField extends StatefulWidget {
  const AutoFocusingSearchField({
    required this.searchText,
    this.onClearPressed,
    this.onSubmitted,
    this.onChanged,
    this.hintText,
    Key? key,
  }) : super(key: key);

  final String searchText;
  final String? hintText;
  final void Function()? onClearPressed;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  @override
  _AutoFocusingSearchFieldState createState() =>
      _AutoFocusingSearchFieldState();
}

class _AutoFocusingSearchFieldState extends State<AutoFocusingSearchField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _setSearchStateValue(widget.searchText);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AutoFocusingSearchField oldWidget) {
    _setSearchStateValue(widget.searchText);
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

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _setSearchStateValue(String search) =>
      _controller.value = TextEditingValue(
        text: search,
        selection: TextSelection(
          baseOffset: search.length,
          extentOffset: search.length,
        ),
      );

  void _shouldRequestFocus(String search) {
    if (search.isEmpty) {
      _focusNode.requestFocus();
    }
  }
}
