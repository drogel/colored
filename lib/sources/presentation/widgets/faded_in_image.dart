import 'package:colored/sources/app/styling/durations.dart' as durations;
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FadedInImage extends StatelessWidget {
  const FadedInImage({
    @required this.image,
    this.size = 256,
    Key key,
  })  : assert(image != null),
        super(key: key);

  final ImageProvider image;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: size,
        width: size,
        child: Center(
          child: FadeInImage(
            fadeInDuration: durations.longPresenting,
            placeholder: Image.memory(kTransparentImage).image,
            image: image,
          ),
        ),
      );
}
