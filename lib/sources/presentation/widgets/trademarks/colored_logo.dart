import 'package:colored/resources/asset_paths.dart' as asset_paths;
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

const _kIconSize = 56.0;

class ColoredLogo extends StatelessWidget {
  const ColoredLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline3!;
    final radii = RadiusData.of(context)!.radiiScheme;
    final padding = PaddingData.of(context)!.paddingScheme;
    return Center(
      child: Container(
        height: _kIconSize,
        width: _kIconSize,
        decoration: BoxDecoration(
          color: textStyle.color,
          borderRadius: BorderRadius.all(radii.medium),
        ),
        child: Padding(
          padding: padding.medium,
          child: Image.asset(asset_paths.smallLogo),
        ),
      ),
    );
  }
}
