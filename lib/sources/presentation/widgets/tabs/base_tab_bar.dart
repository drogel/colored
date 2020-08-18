import 'package:colored/sources/presentation/widgets/tabs/tab_page.dart';
import 'package:flutter/material.dart';

abstract class BaseTabBar extends StatelessWidget {
  const BaseTabBar({
    @required this.tabs,
    this.onTap,
    this.currentIndex,
    Key key,
  })  : assert(tabs != null),
        super(key: key);

  final List<TabPage> tabs;
  final void Function(int) onTap;
  final int currentIndex;
}
