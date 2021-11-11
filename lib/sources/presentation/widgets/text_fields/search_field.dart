import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/presentation/widgets/buttons/plain_icon_button.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    required this.controller,
    this.focusNode,
    this.onClearPressed,
    this.onSubmitted,
    this.onChanged,
    this.hintText,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function()? onClearPressed;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radii = RadiusData.of(context)!.radiiScheme;
    final borderRadius = BorderRadius.all(radii.medium);
    final padding = PaddingData.of(context)!.paddingScheme;
    return Theme(
      data: theme.copyWith(canvasColor: theme.colorScheme.primaryVariant),
      child: Material(
        borderRadius: borderRadius,
        elevation: theme.appBarTheme.elevation!,
        child: TextField(
          controller: controller,
          style: theme.textTheme.headline6,
          focusNode: focusNode,
          textCapitalization: TextCapitalization.sentences,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.only(left: padding.large.left),
            filled: true,
            fillColor: theme.colorScheme.primaryVariant,
            prefixIcon: Icon(Icons.search, color: theme.hintColor),
            suffixIcon: PlainIconButton(
              icon: const Icon(Icons.clear),
              onPressed: controller.text.isEmpty ? null : _onClearPressed,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                style: BorderStyle.none,
                width: 0,
              ),
              borderRadius: borderRadius,
            ),
          ),
        ),
      ),
    );
  }

  void _onClearPressed() {
    controller.clear();
    final onClearPressed = this.onClearPressed;
    if (onClearPressed != null) {
      onClearPressed();
    }
  }
}
