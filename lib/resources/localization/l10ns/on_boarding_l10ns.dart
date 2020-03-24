import 'package:colored/resources/localization/localization_provider.dart';

class OnBoardingL10ns extends LocaleCodeAware {
  const OnBoardingL10ns(String localeCode) : super(localeCode);

  static final Map<String, Map<String, String>> _values = {
    'en': {
      'welcome': 'Welcome to',
      'slogan': 'The fastest way to convert colors.',
      'tap': 'Tap',
      'longPress': 'Long-press',
      'tapBody': 'to paste the content of your clipboard.',
      'longPressBody': "to copy a button's text to your clipboard.",
      'useSliders': "Use the sliders",
      'useSlidersBody': "to select any color you want.",
      'useSlidersFooter':
          "Long-press them to select values with more precision.",
    },
    "es": {
      'welcome': 'Bienvenido a',
      'slogan': 'La forma más rápida de convertir colores.',
      'tap': 'Toca',
      'longPress': 'Mantén presionado',
      'tapBody': 'para pegar el contenido de tu portapapeles.',
      'longPressBody': 'para copiar el texto de un botón en tu portapapeles.',
      'useSliders': "Usa los selectores",
      'useSlidersBody': "para escoger el color que quieras.",
      'useSlidersFooter':
          "Mantén presionado un selector para elegir con más precisión.",
    }
  };

  String get welcome => _values[localeCode]['welcome'];
  String get slogan => _values[localeCode]['slogan'];
  String get tap => _values[localeCode]['tap'];
  String get longPress => _values[localeCode]['longPress'];
  String get tapBody => _values[localeCode]['tapBody'];
  String get longPressBody => _values[localeCode]['longPressBody'];
  String get useSliders => _values[localeCode]['useSliders'];
  String get useSlidersBody => _values[localeCode]['useSlidersBody'];
  String get useSlidersFooter => _values[localeCode]['useSlidersFooter'];
}
