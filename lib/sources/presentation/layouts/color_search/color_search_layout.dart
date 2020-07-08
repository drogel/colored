import 'package:colored/sources/domain/view_models/names_list/names_list_data.dart';
import 'package:colored/sources/presentation/layouts/color_search/color_search_field.dart';
import 'package:colored/sources/presentation/widgets/buttons/plain_icon_button.dart';
import 'package:flutter/material.dart';

class ColorSearchLayout extends StatelessWidget {
  const ColorSearchLayout({
    @required this.flexibleSpaceChild,
    this.onBackPressed,
    Key key,
  })  : assert(flexibleSpaceChild != null),
        super(key: key);

  final Widget flexibleSpaceChild;
  final void Function() onBackPressed;

  @override
  Widget build(BuildContext context) {
    final data = NamesListData.of(context);
    return AppBar(
      title: ColorSearchField(
        prefixIcon: PlainIconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _onBackPressed(data),
        ),
      ),
      centerTitle: true,
      flexibleSpace: Align(
        alignment: Alignment.bottomCenter,
        child: flexibleSpaceChild,
      ),
    );
  }

  void _onBackPressed(NamesListData data) {
    data.onBackPressed();
    onBackPressed();
  }
}
