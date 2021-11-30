import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/opacity/opacity_scheme.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/presentation/widgets/containers/gradient_circle.dart';
import 'package:flutter/material.dart';

const _kOptionLeadingSize = 24.0;
const _kOptionSpacing = 1.0;

class AutocompleteOptionsList extends StatelessWidget {
  const AutocompleteOptionsList({
    required this.options,
    required this.onSelected,
    required this.availableWidth,
    required this.selectedOptionIndex,
    this.maxVisibleOptions = 4,
    Key? key,
  }) : super(key: key);

  final void Function(Palette) onSelected;
  final Iterable<Palette> options;
  final double availableWidth;
  final int selectedOptionIndex;
  final int maxVisibleOptions;

  @override
  Widget build(BuildContext context) {
    final elevation = ElevationData.of(context)!.elevationScheme.medium;
    final radii = RadiusData.of(context)!.radiiScheme;
    final paddingScheme = PaddingData.of(context)!.paddingScheme;
    final opacityScheme = OpacityData.of(context)!.opacityScheme;
    final padding = paddingScheme.medium;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final optionsLenght = options.length.clamp(0, maxVisibleOptions);
    return Padding(
      padding: EdgeInsets.only(top: paddingScheme.small.top),
      child: Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: elevation,
          borderRadius: BorderRadius.all(radii.medium),
          child: SizedBox(
            height: (56.0 + _kOptionSpacing) * optionsLenght + padding.vertical,
            width: availableWidth,
            child: ListView.separated(
              padding: padding,
              itemCount: options.length,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(_kOptionSpacing),
              ),
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return Ink(
                  decoration: BoxDecoration(
                    color: _optionColor(
                      colorScheme,
                      opacityScheme: opacityScheme,
                      optionIndex: index,
                      selectedIndex: selectedOptionIndex,
                    ),
                    borderRadius: BorderRadius.all(radii.small),
                  ),
                  child: ListTile(
                    leading: SizedBox(
                      height: _kOptionLeadingSize,
                      width: _kOptionLeadingSize,
                      child: GradientCircle(hexCodes: option.hexCodes),
                    ),
                    horizontalTitleGap: 0,
                    title: Text(option.name, style: textTheme.bodyText1),
                    onTap: () => onSelected(option),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(radii.small),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Color _optionColor(
    ColorScheme colorScheme, {
    required OpacityScheme opacityScheme,
    required int optionIndex,
    required selectedIndex,
  }) =>
      optionIndex == selectedIndex
          ? colorScheme.secondaryVariant.withOpacity(opacityScheme.shadow)
          : colorScheme.primaryVariant;
}
