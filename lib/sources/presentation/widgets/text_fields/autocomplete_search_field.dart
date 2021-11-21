import 'package:colored/sources/domain/data_models/nameable.dart';
import 'package:colored/sources/presentation/widgets/lists/autocomplete_options_list.dart';
import 'package:colored/sources/presentation/widgets/text_fields/auto_focusing_search_field.dart';
import 'package:flutter/material.dart';

class AutocompleteSearchField extends StatelessWidget {
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
  final Iterable<Nameable> autocompleteOptions;
  final String? hintText;
  final void Function()? onClearPressed;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) => Autocomplete<Nameable>(
          optionsBuilder: _buildOptions,
          onSelected: _onOptionSelected,
          displayStringForOption: (nameable) => nameable.name,
          fieldViewBuilder: (
            context,
            controller,
            focusNode,
            onFieldSubmitted,
          ) =>
              AutoFocusingSearchField(
            controller: controller,
            focusNode: focusNode,
            searchText: searchText,
            onClearPressed: onClearPressed,
            onChanged: onChanged,
            hintText: hintText,
            onSubmitted: onSubmitted,
          ),
          optionsViewBuilder: (_, onSelected, options) =>
              AutocompleteOptionsList(
            options: options,
            onSelected: onSelected,
            availableWidth: constraints.maxWidth,
          ),
        ),
      );

  Iterable<Nameable> _buildOptions(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return [];
    }
    final filteredOptions = autocompleteOptions.where((option) {
      final name = option.name.toLowerCase();
      final textFieldValue = textEditingValue.text.toLowerCase();
      return name.contains(textFieldValue) && name != textFieldValue;
    });
    return filteredOptions;
  }

  void _onOptionSelected(Nameable nameable) {
    final _onSubmitted = onSubmitted;
    if (_onSubmitted == null) {
      return;
    }
    _onSubmitted(nameable.name);
  }
}
