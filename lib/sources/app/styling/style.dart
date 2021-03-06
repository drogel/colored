import 'package:colored/sources/app/styling/blur/blur_data.dart';
import 'package:colored/sources/app/styling/blur/blur_scheme.dart';
import 'package:colored/sources/app/styling/blur/default_blur_scheme.dart';
import 'package:colored/sources/app/styling/curves/curve_data.dart';
import 'package:colored/sources/app/styling/curves/curve_scheme.dart';
import 'package:colored/sources/app/styling/curves/default_curve_scheme.dart';
import 'package:colored/sources/app/styling/duration/default_duration_scheme.dart';
import 'package:colored/sources/app/styling/duration/duration_data.dart';
import 'package:colored/sources/app/styling/duration/duration_scheme.dart';
import 'package:colored/sources/app/styling/elevation/default_elevation_scheme.dart';
import 'package:colored/sources/app/styling/elevation/elevation_data.dart';
import 'package:colored/sources/app/styling/elevation/elevation_scheme.dart';
import 'package:colored/sources/app/styling/opacity/default_opacity_scheme.dart';
import 'package:colored/sources/app/styling/opacity/opacity_data.dart';
import 'package:colored/sources/app/styling/opacity/opacity_scheme.dart';
import 'package:colored/sources/app/styling/padding/default_padding_scheme.dart';
import 'package:colored/sources/app/styling/padding/padding_data.dart';
import 'package:colored/sources/app/styling/padding/padding_scheme.dart';
import 'package:colored/sources/app/styling/radii/default_radii_scheme.dart';
import 'package:colored/sources/app/styling/radii/radii_scheme.dart';
import 'package:colored/sources/app/styling/radii/radius_data.dart';
import 'package:flutter/material.dart';

class Style extends StatelessWidget {
  const Style({
    required this.child,
    Key? key,
    this.curveScheme = const DefaultCurveScheme(),
    this.durationScheme = const DefaultDurationScheme(),
    this.opacityScheme = const DefaultOpacityScheme(),
    this.blurScheme = const DefaultBlurScheme(),
    this.paddingScheme = const DefaultPaddingScheme(),
    this.radiiScheme = const DefaultRadiiScheme(),
    this.elevationScheme = const DefaultElevationScheme(),
  }) : super(key: key);

  final CurveScheme curveScheme;
  final DurationScheme durationScheme;
  final OpacityScheme opacityScheme;
  final BlurScheme blurScheme;
  final PaddingScheme paddingScheme;
  final RadiiScheme radiiScheme;
  final ElevationScheme elevationScheme;
  final Widget child;

  @override
  Widget build(BuildContext context) => ElevationData(
        elevationScheme: elevationScheme,
        child: RadiusData(
          radiiScheme: radiiScheme,
          child: PaddingData(
            paddingScheme: paddingScheme,
            child: BlurData(
              blurScheme: blurScheme,
              child: OpacityData(
                opacityScheme: opacityScheme,
                child: DurationData(
                  durationScheme: durationScheme,
                  child: CurveData(
                    curveScheme: curveScheme,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
