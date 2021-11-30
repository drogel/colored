import 'package:colored/sources/domain/data_models/nameable.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/presentation/widgets/lists/autocomplete_options_list.dart';
import 'package:colored/sources/presentation/widgets/text_fields/auto_focusing_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kMaxVisibleOptions = 5;

class AutocompleteSearchField extends StatefulWidget {
  const AutocompleteSearchField({
    required this.searchText,
    required this.autocompleteOptions,
    this.onClearPressed,
    this.onSubmitted,
    this.onChanged,
    this.hintText,
    Key? key,
  }) : super(key: key);

  final String searchText;
  final Iterable<Palette> autocompleteOptions;
  final String? hintText;
  final void Function()? onClearPressed;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  @override
  State<AutocompleteSearchField> createState() =>
      _AutocompleteSearchFieldState();
}

class _AutocompleteSearchFieldState extends State<AutocompleteSearchField> {
  int? _keyboardSelectedIndex;
  Iterable<Palette>? _options;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) => Autocomplete<Palette>(
          optionsBuilder: _buildOptions,
          onSelected: _onOptionSelected,
          displayStringForOption: (nameable) => nameable.name,
          fieldViewBuilder: (
            context,
            controller,
            focusNode,
            onFieldSubmitted,
          ) =>
              RawKeyboardListener(
            focusNode: focusNode,
            onKey: _handleKey,
            child: AutoFocusingSearchField(
              controller: controller,
              searchText: widget.searchText,
              onClearPressed: _onClear,
              onChanged: _onChanged,
              hintText: widget.hintText,
              onSubmitted: (str) => _onSubmitted(str, controller: controller),
            ),
          ),
          optionsViewBuilder: (_, onSelected, options) {
            _clampSelectedIndex(options);
            _options = options;
            return AutocompleteOptionsList(
              options: options,
              selectedOptionIndex: _keyboardSelectedIndex,
              onSelected: onSelected,
              availableWidth: constraints.maxWidth,
              maxVisibleOptions: _kMaxVisibleOptions,
            );
          },
        ),
      );

  Iterable<Palette> _buildOptions(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return [];
    }
    final filteredOptions = widget.autocompleteOptions.where((option) {
      final name = option.name.toLowerCase();
      final textFieldValue = textEditingValue.text.toLowerCase();
      return name.contains(textFieldValue);
    });
    return filteredOptions;
  }

  void _onChanged(String value) {
    final onChanged = widget.onChanged;
    if (value.isEmpty) {
      _resetSelectedIndex();
    }
    if (onChanged == null) {
      return;
    }
    onChanged(value);
  }

  void _onOptionSelected(Nameable nameable) {
    final _onSubmitted = widget.onSubmitted;
    if (_onSubmitted == null) {
      return;
    }
    _onSubmitted(nameable.name);
  }

  void _handleKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      return;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _decrementSelectedIndex();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _incrementSelectedIndex();
    } else {
      _resetSelectedIndex();
    }
  }

  void _onSubmitted(String value, {required TextEditingController controller}) {
    final onSubmitted = widget.onSubmitted;
    if (onSubmitted == null) {
      return;
    }
    final options = _options;
    final selectedIndex = _keyboardSelectedIndex;
    if (options == null || selectedIndex == null) {
      return onSubmitted(value);
    }
    final selectedOption = options.elementAt(selectedIndex).name;
    onSubmitted(selectedOption);
    controller.text = selectedOption;
  }

  void _onClear() {
    final onClear = widget.onClearPressed;
    if (onClear == null) {
      return;
    }
    _resetSelectedIndex();
    onClear();
  }

  void _incrementSelectedIndex() {
    _keyboardSelectedIndex ??= -1;
    setState(() => _keyboardSelectedIndex = _keyboardSelectedIndex! + 1);
  }

  void _decrementSelectedIndex() {
    final keyboardSelectedIndex = _keyboardSelectedIndex;
    if (keyboardSelectedIndex == null) {
      return;
    }
    setState(() => _keyboardSelectedIndex = keyboardSelectedIndex - 1);
  }

  void _clampSelectedIndex(Iterable<Palette> options) {
    final optionsLenght = options.length.clamp(0, options.length - 1);
    _keyboardSelectedIndex = _keyboardSelectedIndex?.clamp(0, optionsLenght);
  }

  void _resetSelectedIndex() => _keyboardSelectedIndex = null;
}
