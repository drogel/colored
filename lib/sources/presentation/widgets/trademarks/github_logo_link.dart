import 'package:colored/configuration/flavor_config.dart';
import 'package:colored/resources/asset_paths.dart' as asset_paths;
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/data/services/url_launcher/safe_url_launcher.dart';
import 'package:colored/sources/data/services/url_launcher/url_launcher.dart';
import 'package:colored/sources/presentation/widgets/animations/animated_image_color.dart';
import 'package:flutter/material.dart';

class GithubLogoLink extends StatefulWidget {
  const GithubLogoLink({
    this.size,
    UrlLauncher? urlLauncher,
    Key? key,
  })  : _urlLauncher = urlLauncher,
        super(key: key);

  static final _repoUrl = FlavorConfig.instance.values.repositoryLink;

  final double? size;
  final UrlLauncher? _urlLauncher;

  @override
  _GithubLogoLinkState createState() => _GithubLogoLinkState();
}

class _GithubLogoLinkState extends State<GithubLogoLink> {
  late AnimatedImageColorState _currentState;
  late Color _idleLogoColor;
  late Color _hoveringLogoColor;

  @override
  void didChangeDependencies() {
    _idleLogoColor = Theme.of(context).colorScheme.onError;
    _hoveringLogoColor = Theme.of(context).colorScheme.secondary;
    _currentState = AnimatedImageColorState.beginColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final padding = PaddingData.of(context)!.paddingScheme;
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
    final safeUrlLauncher = SafeUrlLauncher(url: GithubLogoLink._repoUrl);
    final urlLauncher = widget._urlLauncher ?? safeUrlLauncher;
    setState(() => _currentState = AnimatedImageColorState.beginColor);
    urlLauncher.launch();
  }

  void _updateLogoColor(bool isHovering) => isHovering
      ? setState(() => _currentState = AnimatedImageColorState.endColor)
      : setState(() => _currentState = AnimatedImageColorState.beginColor);
}
