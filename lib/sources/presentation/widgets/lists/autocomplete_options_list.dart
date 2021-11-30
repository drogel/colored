import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/presentation/widgets/cards/autocomplete_option_tile.dart';
import 'package:flutter/material.dart';

const _kOptionSpacing = 1.0;

class AutocompleteOptionsList extends StatelessWidget {
  const AutocompleteOptionsList({
    required this.options,
    required this.onSelected,
    required this.availableWidth,
    required this.maxVisibleOptions,
    this.selectedOptionIndex,
    Key? key,
  }) : super(key: key);

  final void Function(Palette) onSelected;
  final Iterable<Palette> options;
  final double availableWidth;
  final int? selectedOptionIndex;
  final int maxVisibleOptions;

  @override
  Widget build(BuildContext context) {
    final elevation = ElevationData.of(context)!.elevationScheme.medium;
    final radii = RadiusData.of(context)!.radiiScheme;
    final paddingScheme = PaddingData.of(context)!.paddingScheme;
    final padding = paddingScheme.medium;
    final optionsLenght = options.length.clamp(0, maxVisibleOptions);
    return Padding(
      padding: EdgeInsets.only(top: paddingScheme.small.top),
      child: Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: elevation,
          borderRadius: BorderRadius.all(radii.medium),
          child: SizedBox(
            height: (56.0 + _kOptionSpacing) * optionsLenght +
                padding.vertical +
                _kOptionSpacing,
            width: availableWidth,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: padding,
              itemCount: options.length,
              separatorBuilder: (_, __) => const _OptionSeparator(),
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return AutocompleteOptionTile(
                  title: option.name,
                  hexCodes: option.hexCodes,
                  isHighlighted: selectedOptionIndex == index,
                  onTap: () => onSelected(option),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionSeparator extends StatelessWidget {
  const _OptionSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(_kOptionSpacing),
      );
}
