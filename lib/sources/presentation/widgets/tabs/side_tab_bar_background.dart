import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:flutter/material.dart';

class SideTabBarBackground extends StatelessWidget {
  const SideTabBarBackground({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = PaddingData.of(context)!.paddingScheme;
    return Material(
      color: theme.primaryColor,
      child: Padding(
        padding: padding.large,
        child: Theme(
          data: theme.copyWith(highlightColor: Colors.transparent),
          child: SafeArea(
            child: child,
          ),
        ),
      ),
    );
  }
}
