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
    final textTheme = Theme.of(context).textTheme.caption;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Row(
        children: [
          if (_style == _AboutMarkStyle.expanded)
            Text(
              "Made with ",
              style: textTheme.copyWith(height: _kTextHeight),
            ),
          if (_style == _AboutMarkStyle.expanded)
            Icon(
              Icons.favorite,
              size: textTheme.fontSize,
              color: textTheme.color,
            ),
          if (_style == _AboutMarkStyle.expanded)
            Text(
              " by Diego Rogel",
              style: textTheme.copyWith(height: _kTextHeight),
            )
        ],
      ),
    );
  }
}

enum _AboutMarkStyle {
  expanded,
  compact,
}
