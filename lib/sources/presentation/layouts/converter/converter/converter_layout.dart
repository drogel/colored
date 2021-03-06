import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/padding/padding_scheme.dart';
import 'package:colored/sources/domain/data_models/format.dart';
import 'package:colored/sources/domain/view_models/converter/converter/converter_data.dart';
import 'package:colored/sources/presentation/layouts/converter/displayed_formats/displayed_formats_layout.dart';
import 'package:colored/sources/presentation/layouts/converter/picker/picker_layout.dart';
import 'package:colored/sources/presentation/widgets/animations/swiping_cross_fade.dart';
import 'package:colored/sources/presentation/widgets/containers/overlay_container.dart';
import 'package:colored/sources/presentation/widgets/layouts/dynamic_bottom_padding.dart';
import 'package:flutter/material.dart';

const _kFormatButtonMinSpace = 140.0;
const _kOverlayContainerMaxHeight = 300.0;

class ConverterLayout extends StatelessWidget {
  const ConverterLayout({
    this.background,
    this.slidersShownIfSpaceAvailable = true,
  });

  final Widget? background;
  final bool slidersShownIfSpaceAvailable;

  @override
  Widget build(BuildContext context) {
    final data = ConverterData.of(context)!;
    final padding = PaddingData.of(context)!.paddingScheme;
    final maxButtonCount = Format.values.length;
    final maxContainerWidth = (maxButtonCount + 1.5) * _kFormatButtonMinSpace;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        if (background != null) background!,
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContainerWidth),
          child: DynamicBottomPadding(
            child: OverlayContainer(
              child: LayoutBuilder(
                builder: (_, outerBox) {
                  final showChild = _shouldShowOverlayChild(outerBox.maxHeight);
                  return SwipingCrossFade(
                    showChild: showChild,
                    enableGestures: false,
                    header: Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding.base),
                      child: DisplayedFormatsLayout(
                        buttonMinSpace: _kFormatButtonMinSpace,
                        converterData: data,
                      ),
                    ),
                    child: Padding(
                      padding: _getInnerPadding(padding),
                      child: PickerLayout(availableHeight: outerBox.maxHeight),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _shouldShowOverlayChild(double availableHeight) {
    if (slidersShownIfSpaceAvailable) {
      final hasAvailableRoom = availableHeight >= _kOverlayContainerMaxHeight;
      return hasAvailableRoom;
    } else {
      return slidersShownIfSpaceAvailable;
    }
  }

  EdgeInsets _getInnerPadding(PaddingScheme padding) {
    final defaultPaddingValue = padding.large.bottom + padding.small.top;
    return EdgeInsets.only(bottom: defaultPaddingValue, top: padding.small.top);
  }
}
