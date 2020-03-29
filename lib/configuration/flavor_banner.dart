import 'package:flutter/material.dart';

import 'flavor_config.dart';

class FlavorBanner extends StatelessWidget {
  const FlavorBanner({@required this.child}) : assert(child != null);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (FlavorConfig.isProduction()) {
      return child;
    }
    final bannerConfig = _getDefaultBanner();
    return Stack(
      children: <Widget>[child, _buildBanner(context, bannerConfig)],
    );
  }

  BannerConfig _getDefaultBanner() => BannerConfig(
      bannerName: FlavorConfig.instance.name,
      bannerColor: FlavorConfig.instance.color);

  Widget _buildBanner(BuildContext context, BannerConfig bannerConfig) =>
      Container(
        width: 50,
        height: 50,
        child: CustomPaint(
          painter: BannerPainter(
              message: bannerConfig.bannerName,
              textDirection: Directionality.of(context),
              layoutDirection: Directionality.of(context),
              location: BannerLocation.topStart,
              color: bannerConfig.bannerColor),
        ),
      );
}

class BannerConfig {
  const BannerConfig({@required this.bannerName, @required this.bannerColor});

  final String bannerName;
  final Color bannerColor;
}
