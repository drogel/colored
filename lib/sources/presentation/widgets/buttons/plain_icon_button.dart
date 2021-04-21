import 'package:flutter/material.dart';

class PlainIconButton extends StatelessWidget {
  const PlainIconButton({
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final actionsTheme = Theme.of(context).appBarTheme.actionsIconTheme!;
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(color: actionsTheme.color),
      ),
      child: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
