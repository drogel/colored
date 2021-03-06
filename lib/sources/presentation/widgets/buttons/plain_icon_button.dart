import 'package:flutter/material.dart';

class PlainIconButton extends StatelessWidget {
  const PlainIconButton({
    required this.icon,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final actionsTheme = Theme.of(context).appBarTheme.actionsIconTheme;
    final primaryColor = Theme.of(context).primaryColor;
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(color: actionsTheme?.color ?? primaryColor),
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
