import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:colored/sources/presentation/widgets/containers/overlay_container.dart';
import 'package:flutter/material.dart';

class ColorCardTile extends StatelessWidget {
  const ColorCardTile({
    @required this.title,
    @required this.subtitle,
    this.borderRadius,
    Key key,
  }) : super(key: key);

  final BorderRadius borderRadius;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    final radii = RadiusData.of(context).radiiScheme;
    final parentRadius = borderRadius ?? BorderRadius.all(radii.large);
    final titleMargin = padding.small;
    final marginBorderRadius = BorderRadius.circular(titleMargin.left);
    final decorationBorderRadius = parentRadius.subtract(marginBorderRadius);
    return Padding(
      padding: titleMargin,
      child: OverlayContainer(
        borderRadius: decorationBorderRadius,
        elevation: 0,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
