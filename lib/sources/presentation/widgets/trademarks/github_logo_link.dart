import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:flutter/material.dart';
import 'package:colored/resources/asset_paths.dart' as asset_paths;

class GithubLogoLink extends StatelessWidget {
  const GithubLogoLink({this.height, this.width, Key key}) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding.medium.left),
      child: Image.asset(
        asset_paths.githubLogo,
        height: height,
        width: width,
      ),
    );
  }
}
