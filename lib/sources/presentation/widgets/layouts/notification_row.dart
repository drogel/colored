import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:flutter/material.dart';

class NotificationRow extends StatelessWidget {
  const NotificationRow({required this.message, this.icon, Key? key})
      : super(key: key);

  final String message;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    final paddingScheme = PaddingData.of(context)!.paddingScheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (icon != null) icon!,
        SizedBox(width: paddingScheme.large.top),
        Text(message),
      ],
    );
  }
}
