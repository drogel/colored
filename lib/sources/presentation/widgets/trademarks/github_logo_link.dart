import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:flutter/material.dart';
import 'package:colored/resources/asset_paths.dart' as asset_paths;
import 'package:url_launcher/url_launcher.dart';

class GithubLogoLink extends StatefulWidget {
  const GithubLogoLink({this.height, this.width, Key key}) : super(key: key);

  final double height;
  final double width;

  @override
  _GithubLogoLinkState createState() => _GithubLogoLinkState();
}

class _GithubLogoLinkState extends State<GithubLogoLink> {
  Color _currentLogoColor;
  Color _idleLogoColor;
  Color _hoveringLogoColor;

  @override
  void didChangeDependencies() {
    _idleLogoColor = Theme.of(context).colorScheme.onError;
    _hoveringLogoColor = Theme.of(context).colorScheme.secondary;
    _currentLogoColor = _idleLogoColor;
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
        child: Image.asset(
          asset_paths.githubLogo,
          height: widget.height,
          width: widget.width,
          color: _currentLogoColor,
        ),
      ),
    );
  }

  Future<void> _launchGithubURL() async {
    const url = asset_paths.githubColoredLink;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _updateLogoColor(bool isHovering) => isHovering
      ? setState(() => _currentLogoColor = _hoveringLogoColor)
      : setState(() => _currentLogoColor = _idleLogoColor);
}
