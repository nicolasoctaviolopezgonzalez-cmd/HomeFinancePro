class AppConfig {
  static const String appName = 'HomeFinance Pro';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';
  
  static const bool enableAnalytics = true;
  static const bool enableCrashlytics = true;
  static const bool enableLogging = true;
  
  static const Duration sessionTimeout = Duration(minutes: 15);
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  
  static const String defaultCurrency = 'USD';
  static const String defaultLocale = 'es_ES';
  
  static const int maxTransactionsPerPage = 20;
  static const int maxCategoriesPerRequest = 50;
  
  static late final bool _isInitialized;
  
  static Future<void> initialize() async {
    _isInitialized = true;
  }
  
  static bool get isInitialized => _isInitialized;
  
  static const String databaseName = 'home_finance_pro.db';
  static const int databaseVersion = 1;
}
