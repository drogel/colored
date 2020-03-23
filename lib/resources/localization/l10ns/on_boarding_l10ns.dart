import 'package:colored/resources/localization/localization_provider.dart';

class OnBoardingL10ns extends LocaleCodeAware {
  const OnBoardingL10ns(String localeCode) : super(localeCode);

  static final Map<String, Map<String, String>> _values = {
    'en': {
      'welcome': 'Welcome to',
      'slogan': 'The fastest way to convert colors.',
      'tap': 'Tap it',
      'longPress': 'Long-press a button',
      'tapBody': 'to paste the content of your clipboard.',
      'longPressBody': 'to copy its text to your clipboard.',
    },
    "es": {
      'welcome': 'Bienvenido a',
      'slogan': 'La forma más rápida de convertir colores.',
      'tap': 'Tócalo',
      'longPress': 'Mantén presionado un botón',
      'tapBody': 'para pegar el contenido de tu portapapeles.',
      'longPressBody': 'para copiar su texto en tu portapapeles.',
    }
  };

  String get welcome => _values[localeCode]['welcome'];
  String get slogan => _values[localeCode]['slogan'];
  String get tap  => _values[localeCode]['tap'];
  String get longPress => _values[localeCode]['longPress'];
  String get tapBody => _values[localeCode]['tapBody'];
  String get longPressBody => _values[localeCode]['longPressBody'];
}