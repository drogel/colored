import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:flutter/material.dart';

class NamingErrorRow extends StatelessWidget {
  const NamingErrorRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context).naming;
    final bodyTextStyle = Theme.of(context).textTheme.bodyText1;
    final colors = Theme.of(context).colorScheme;
    final paddingScheme = PaddingData.of(context).paddingScheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.offline_bolt,
          size: bodyTextStyle.fontSize + 3,
          color: colors.error,
        ),
        SizedBox(width: paddingScheme.large.top),
        Text(localization.noConnection),
      ],
    );
  }
}
