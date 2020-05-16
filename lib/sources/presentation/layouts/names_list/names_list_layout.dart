import 'package:colored/sources/presentation/widgets/containers/color_card.dart';
import 'package:flutter/material.dart';

class NamesListLayout extends StatelessWidget {
  const NamesListLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: Colors.primaries.length,
        itemBuilder: (_, i) => ColorCard(
          backgroundColor: Colors.primaries[i],
          title: "Test color",
          subtitle: "#34B4F5",
        ),
      );
}
