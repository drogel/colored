import 'package:colored/resources/asset_paths.dart' as asset_paths;
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/data/services/url_launcher/safe_url_launcher.dart';
import 'package:colored/sources/data/services/url_launcher/url_launcher.dart';
import 'package:colored/sources/presentation/widgets/animations/animated_image_color.dart';
import 'package:flutter/material.dart';

const _kUrlToLaunch = asset_paths.githubColoredLink;

class GithubLogoLink extends StatefulWidget {
  const GithubLogoLink({
    this.size,
    UrlLauncher urlLauncher = const SafeUrlLauncher(url: _kUrlToLaunch),
    Key key,
  })  : assert(urlLauncher != null),
        _urlLauncher = urlLauncher,
        super(key: key);

  final double size;
  final UrlLauncher _urlLauncher;

  @override
  _GithubLogoLinkState createState() => _GithubLogoLinkState();
}

class _GithubLogoLinkState extends State<GithubLogoLink> {
  AnimatedImageColorState _currentState;
  Color _idleLogoColor;
  Color _hoveringLogoColor;

  @override
  void didChangeDependencies() {
    _idleLogoColor = Theme.of(context).colorScheme.onError;
    _hoveringLogoColor = Theme.of(context).colorScheme.secondary;
    _currentState = AnimatedImageColorState.beginColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context).paddingScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding.medium.left),
      child: InkWell(
        onTap: _launchUrl,
        onHover: _updateLogoColor,
        child: AnimatedImageColor(
          asset_paths.githubLogo,
          size: widget.size,
          begin: _idleLogoColor,
          end: _hoveringLogoColor,
          state: _currentState,
        ),
      ),
    );
  }

  void _launchUrl() {
    setState(() => _currentState = AnimatedImageColorState.beginColor);
    widget._urlLauncher.launch();
  }

  void _updateLogoColor(bool isHovering) => isHovering
      ? setState(() => _currentState = AnimatedImageColorState.endColor)
      : setState(() => _currentState = AnimatedImageColorState.beginColor);
}
