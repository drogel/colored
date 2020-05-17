import 'package:colored/sources/app/styling/padding.dart' as padding;
import 'package:colored/sources/presentation/widgets/containers/color_card.dart';
import 'package:flutter/material.dart';

class NamesListLayout extends StatelessWidget {
  const NamesListLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: GridView.builder(
          padding: padding.lists,
          itemCount: Colors.primaries.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemBuilder: (_, i) => ColorCard(
            backgroundColor: Colors.primaries[i],
            title: "Test color",
            subtitle: "#34B4F5",
          ),
        ),
      );
}
