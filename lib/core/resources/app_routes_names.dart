class AppRoutesNames {
  AppRoutesNames._();

  static const String root = '/';
  static const String splash = 'splash';
  static const String onBoarding = 'onBoarding';
  static const String signIn = 'signIn';
  static const String signUp = 'signUp';
  static const String home = 'home';
  static const String profile = 'profile';
  static const String settings = 'settings';
  static const String aiStylist = 'aiStylist';
  static const String hairstyleDetail = 'hairstyleDetail';
  static const String styleResult = 'styleResult';

  /// My Formulas list (Formulas tab entry point)
  static const String myFormulas = 'myFormulas';
  static const String myFormulasPath = '/my_formulas';

  /// All-in-one PageView calculator (primary flow — manages its own cubit)
  static const String formulaCalculator = 'formulaCalculator';
  static const String formulaCalculatorPath = '/formula_calculator';

  /// Results screen (extra: `Map<String,dynamic>` with currentLevel, targetLevel, brand)
  static const String formulaResults = 'formulaResults';
  static const String formulaResultsPath = '/formula_results';

  /// Full timer detail screen (extra: TimerSession object)
  static const String timerDetail = 'timerDetail';
  static const String timerDetailPath = '/formulas/timer';
}
