import 'package:colored/resources/localization/localization_provider.dart';

class ConverterL10ns extends LocaleCodeAware {
  const ConverterL10ns(String localeCode) : super(localeCode);

  static final Map<String, Map<String, String>> _values = {
    'en': {
      'pageTitle' : 'Converter',
      'tooltipMessage': 'Copied!',
      'tooltipError': 'Wrong format',
      'hex': 'Hex',
      'rgb': 'RGB',
      'colorConverter': 'Color converter',
    },
    "es": {
      'pageTitle' : 'Conversor',
      'tooltipMessage': '¡Copiado!',
      'tooltipError': 'Formato no válido',
      'hex': 'Hex',
      'rgb': 'RGB',
      'colorConverter': 'Conversor de colores',
    }
  };

  String get pageTitle => _values[localeCode]['pageTitle'];
  String get tooltipMessage => _values[localeCode]['tooltipMessage'];
  String get tooltipError => _values[localeCode]['tooltipError'];
  String get hex => _values[localeCode]['hex'];
  String get rgb => _values[localeCode]['rgb'];
  String get colorConverter => _values[localeCode]['colorConverter'];
}
