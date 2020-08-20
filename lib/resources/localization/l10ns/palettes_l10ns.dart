import 'package:colored/resources/localization/localization_provider.dart';

class PalettesL10ns extends LocaleCodeAware {
  const PalettesL10ns(String localeCode) : super(localeCode);

  static final Map<String, Map<String, String>> _values = {
    'en': {
      'pageTitle' : 'Palettes',
    },
    "es": {
      'pageTitle' : 'Paletas',
    }
  };

  String get pageTitle => _values[localeCode]['pageTitle'];
}