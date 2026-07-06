class AppConstants {
  static const String appName = 'HomeFinance Pro';
  static const String appVersion = '1.0.0';
  
  static const List<String> transactionTypes = ['Ingreso', 'Gasto', 'Transferencia'];
  static const List<String> budgetPeriods = ['Semanal', 'Mensual', 'Trimestral', 'Anual'];
  static const List<String> currencies = ['USD', 'EUR', 'MXN', 'ARS', 'COP', 'CLP'];
  static const List<String> priorities = ['Baja', 'Media', 'Alta'];
  
  static const Map<String, String> expenseCategories = {
    'food': '🍔 Comida',
    'transport': '🚗 Transporte',
    'entertainment': '🎮 Entretenimiento',
    'utilities': '💡 Servicios',
    'health': '🏥 Salud',
    'shopping': '🛍️ Compras',
    'education': '📚 Educación',
    'other': '📌 Otros',
  };
  
  static const Map<String, String> incomeCategories = {
    'salary': '💰 Salario',
    'freelance': '💼 Freelance',
    'investment': '📈 Inversión',
    'other': '📌 Otros',
  };
  
  static const Map<String, String> accountTypes = {
    'checking': '🏦 Cuenta Corriente',
    'savings': '💳 Cuenta de Ahorros',
    'credit_card': '💳 Tarjeta de Crédito',
    'cash': '💵 Efectivo',
    'investment': '📈 Inversión',
    'crypto': '₿ Criptomoneda',
  };
  
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String timeFormat = 'HH:mm';
  
  static const double defaultBudgetAlertThreshold = 80.0;
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  static const Duration sessionTimeout = Duration(minutes: 15);
}
