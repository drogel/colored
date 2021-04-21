import 'package:flutter/material.dart';

abstract class TabPage extends Widget {
  IconData get tabIcon;

  String? getTabTitle(BuildContext context);
}