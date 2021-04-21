import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/presentation/widgets/layouts/empty_list_layout.dart';
import 'package:flutter/material.dart';

class NoColorsMessage extends StatelessWidget {
  const NoColorsMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context)!.namesList;
    return EmptyListLayout(child: Text(localization.noColorsFound!));
  }
}
