import 'package:colored/resources/localization/l10ns/converter_l10ns.dart';
import 'package:colored/resources/localization/l10ns/names_list_l10ns.dart';
import 'package:colored/resources/localization/l10ns/naming_l10ns.dart';
import 'package:colored/resources/localization/l10ns/on_boarding_l10ns.dart';
import 'package:colored/resources/localization/l10ns/palettes_l10ns.dart';

abstract class LocaleCodeAware {
  const LocaleCodeAware(this.localeCode);

  final String localeCode;
}

mixin LocalizationProvider on LocaleCodeAware {
  static final Map<String, Map<String, String>> _values = {
    'en': {
      'appTitle': 'Colored',
      'trademarkBegin': 'Made with ',
      'trademarkEnd': ' by Diego Rogel',
    },
    "es": {
      'appTitle': 'Colored',
      'trademarkBegin': 'Hecho con ',
      'trademarkEnd': ' por Diego Rogel',
    }
  };

  String get appTitle => _values[localeCode]['appTitle'];
  String get trademarkBegin => _values[localeCode]['trademarkBegin'];
  String get trademarkEnd => _values[localeCode]['trademarkEnd'];

  OnBoardingL10ns get onBoarding => OnBoardingL10ns(localeCode);

  ConverterL10ns get converter => ConverterL10ns(localeCode);

  NamesListL10ns get namesList => NamesListL10ns(localeCode);

  NamingL10ns get naming => NamingL10ns(localeCode);

  PalettesL10ns get palettes => PalettesL10ns(localeCode);
}
