import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/widgets/layouts/notification_row.dart';
import 'package:flutter/material.dart';

class NamingErrorRow extends StatelessWidget {
  const NamingErrorRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context)!.naming;
    final bodyTextSize = Theme.of(context).textTheme.bodyText1?.fontSize ?? 16;
    final colors = Theme.of(context).colorScheme;
    return NotificationRow(
      icon: Icon(
        Icons.offline_bolt,
        size: bodyTextSize + 3,
        color: colors.error,
      ),
      message: localization.noConnection,
    );
  }
}
