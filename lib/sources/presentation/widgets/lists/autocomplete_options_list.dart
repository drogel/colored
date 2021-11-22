import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/domain/data_models/palette.dart';
import 'package:colored/sources/presentation/widgets/containers/gradient_circle.dart';
import 'package:flutter/material.dart';

const _kOptionLeadingSize = 24.0;

class AutocompleteOptionsList extends StatelessWidget {
  const AutocompleteOptionsList({
    required this.options,
    required this.onSelected,
    required this.availableWidth,
    this.maxOptionsLenght = 4,
    Key? key,
  }) : super(key: key);

  final void Function(Palette) onSelected;
  final Iterable<Palette> options;
  final double availableWidth;
  final int maxOptionsLenght;

  @override
  Widget build(BuildContext context) {
    final elevation = ElevationData.of(context)!.elevationScheme.medium;
    final radii = RadiusData.of(context)!.radiiScheme;
    final paddingScheme = PaddingData.of(context)!.paddingScheme;
    final padding = paddingScheme.medium;
    final textTheme = Theme.of(context).textTheme;
    final optionsLenght = options.length.clamp(0, maxOptionsLenght);
    return Padding(
      padding: EdgeInsets.only(top: paddingScheme.small.top),
      child: Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: elevation,
          borderRadius: BorderRadius.all(radii.medium),
          child: SizedBox(
            height: 56.0 * optionsLenght + padding.top + padding.bottom,
            width: availableWidth,
            child: ListView.builder(
              padding: padding,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return ListTile(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
