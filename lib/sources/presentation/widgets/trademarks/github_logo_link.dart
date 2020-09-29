import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/presentation/widgets/animations/animated_image_color.dart';
import 'package:flutter/material.dart';
import 'package:colored/resources/asset_paths.dart' as asset_paths;
import 'package:url_launcher/url_launcher.dart';

class GithubLogoLink extends StatefulWidget {
  const GithubLogoLink({this.size, Key key}) : super(key: key);

  final double size;

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
        onTap: _launchGithubURL,
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

  // TODO: - Refactor this into its own encapsulated class/logic.
  Future<void> _launchGithubURL() async {
    const url = asset_paths.githubColoredLink;
    if (await canLaunch(url)) {
      setState(() => _currentState = AnimatedImageColorState.beginColor);
      await launch(url);
    }
  }

  void _updateLogoColor(bool isHovering) => isHovering
      ? setState(() => _currentState = AnimatedImageColorState.endColor)
      : setState(() => _currentState = AnimatedImageColorState.beginColor);
}
