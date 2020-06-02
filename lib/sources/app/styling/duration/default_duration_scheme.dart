import 'package:colored/sources/app/styling/duration/duration_constants.dart' as duration;
import 'package:colored/sources/app/styling/duration/duration_scheme.dart';

class DefaultDurationScheme implements DurationScheme {
  const DefaultDurationScheme();

  @override
  Duration get longDismissing => duration.longDismissing;

  @override
  Duration get longPresenting => duration.longPresenting;

  @override
  Duration get mediumDismissing => duration.mediumDismissing;

  @override
  Duration get mediumPresenting => duration.mediumPresenting;

  @override
  Duration get shortDismissing => duration.shortDismissing;

  @override
  Duration get shortPresenting => duration.shortPresenting;
}