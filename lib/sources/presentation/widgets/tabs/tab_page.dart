import 'package:flutter/material.dart';

abstract class TabPage extends Widget {
  Icon get tabIcon;

  String getTabTitle(BuildContext context);
}