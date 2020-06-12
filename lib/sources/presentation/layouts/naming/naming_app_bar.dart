import 'package:colored/resources/localization/localization.dart';
import 'package:colored/sources/domain/data_models/picker_style.dart';
import 'package:colored/sources/domain/view_models/converter/converter_data.dart';
import 'package:colored/sources/presentation/layouts/naming/naming_cross_fade_text.dart';
import 'package:flutter/material.dart';

class NamingAppBar extends StatelessWidget {
  const NamingAppBar({this.onSearchPressed, Key key}) : super(key: key);

  final void Function() onSearchPressed;

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context).converter;
    final converterData = ConverterData.of(context);
    return DefaultTabController(
      length: PickerStyle.values.length,
      child: AppBar(
        title: NamingCrossFadeText(defaultText: localization.colorConverter),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearchPressed,
          ),
        ],
        bottom: TabBar(
          tabs: PickerStyle.values
              .map((style) => Tab(text: style.rawValue))
              .toList(),
          onTap: converterData.onUpdatePickerStyle,
        ),
      ),
    );
  }
}
