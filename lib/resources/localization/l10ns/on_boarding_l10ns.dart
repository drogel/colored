import 'package:colored/resources/localization/localization_provider.dart';

class OnBoardingL10ns extends LocaleCodeAware {
  const OnBoardingL10ns(String localeCode) : super(localeCode);

  static final Map<String, Map<String, String>> _values = {
    'en': {
      'welcome': 'Welcome to',
    },
    "es": {
      'welcome': 'Bienvenido a',
    }
  };

  String get welcome => _values[localeCode]['welcome'];
}