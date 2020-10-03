import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/widgets/trademarks/github_logo_link.dart';
import 'package:flutter/material.dart';

const _kTextHeight = 1.3;

class AboutMark extends StatelessWidget {
  const AboutMark({Key key})
      : _style = _AboutMarkStyle.expanded,
        super(key: key);

  const AboutMark.compact({Key key})
      : _style = _AboutMarkStyle.compact,
        super(key: key);

  final _AboutMarkStyle _style;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.caption;
    final githubLogoSize = 2 * textStyle.fontSize;
    final localization = Localization.of(context);
    return Row(
      children: [
        const SizedBox(width: 1),
        if (_style == _AboutMarkStyle.expanded)
          Text(
            localization.trademarkBegin,
            style: textStyle.copyWith(height: _kTextHeight),
          ),
        if (_style == _AboutMarkStyle.expanded)
          Icon(
            Icons.favorite,
            size: textStyle.fontSize,
            color: textStyle.color,
          ),
        if (_style == _AboutMarkStyle.expanded)
          Text(
            localization.trademarkEnd,
            style: textStyle.copyWith(height: _kTextHeight),
          ),
        GithubLogoLink(size: githubLogoSize),
      ],
    );
  }
}

enum _AboutMarkStyle {
  expanded,
  compact,
}
