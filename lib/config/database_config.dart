import 'package:sqflite/sqflite.dart';

class DatabaseConfig {
  static const String databaseName = 'home_finance_pro.db';
  static const int databaseVersion = 1;
  
  static const String tableUsers = 'users';
  static const String tableAccounts = 'accounts';
  static const String tableCategories = 'categories';
  static const String tableTransactions = 'transactions';
  static const String tableBudgets = 'budgets';
  static const String tableGoals = 'goals';
  static const String tableTransactionTags = 'transaction_tags';
  static const String tableAttachments = 'attachments';
  
  static final List<TableSchema> tables = [
    _usersTable,
    _accountsTable,
    _categoriesTable,
    _transactionsTable,
    _budgetsTable,
    _goalsTable,
    _transactionTagsTable,
    _attachmentsTable,
  ];
  
  static final TableSchema _usersTable = TableSchema(
    name: tableUsers,
    columns: [
      ColumnSchema('id', 'TEXT PRIMARY KEY'),
      ColumnSchema('name', 'TEXT NOT NULL'),
      ColumnSchema('email', 'TEXT UNIQUE NOT NULL'),
      ColumnSchema('profileImageUrl', 'TEXT'),
      ColumnSchema('defaultCurrency', 'TEXT DEFAULT "USD"'),
      ColumnSchema('createdAt', 'INTEGER NOT NULL'),
      ColumnSchema('updatedAt', 'INTEGER NOT NULL'),
    ],
  );
  
  static final TableSchema _accountsTable = TableSchema(
    name: tableAccounts,
    columns: [
      ColumnSchema('id', 'TEXT PRIMARY KEY'),
      ColumnSchema('userId', 'TEXT NOT NULL'),
      ColumnSchema('name', 'TEXT NOT NULL'),
      ColumnSchema('type', 'TEXT NOT NULL'),
      ColumnSchema('balance', 'REAL NOT NULL DEFAULT 0'),
      ColumnSchema('currency', 'TEXT NOT NULL'),
      ColumnSchema('color', 'TEXT'),
      ColumnSchema('icon', 'TEXT'),
      ColumnSchema('isActive', 'INTEGER DEFAULT 1'),
      ColumnSchema('createdAt', 'INTEGER NOT NULL'),
      ColumnSchema('updatedAt', 'INTEGER NOT NULL'),
      ColumnSchema('FOREIGN KEY(userId)', 'REFERENCES users(id) ON DELETE CASCADE'),
    ],
  );
  
  static final TableSchema _categoriesTable = TableSchema(
    name: tableCategories,
    columns: [
      ColumnSchema('id', 'TEXT PRIMARY KEY'),
      ColumnSchema('userId', 'TEXT NOT NULL'),
      ColumnSchema('name', 'TEXT NOT NULL'),
      ColumnSchema('type', 'TEXT NOT NULL'),
      ColumnSchema('icon', 'TEXT'),
      ColumnSchema('color', 'TEXT'),
      ColumnSchema('isDefault', 'INTEGER DEFAULT 0'),
      ColumnSchema('createdAt', 'INTEGER NOT NULL'),
      ColumnSchema('updatedAt', 'INTEGER NOT NULL'),
      ColumnSchema('FOREIGN KEY(userId)', 'REFERENCES users(id) ON DELETE CASCADE'),
    ],
  );
  
  static final TableSchema _transactionsTable = TableSchema(
    name: tableTransactions,
    columns: [
      ColumnSchema('id', 'TEXT PRIMARY KEY'),
      ColumnSchema('userId', 'TEXT NOT NULL'),
      ColumnSchema('accountId', 'TEXT NOT NULL'),
      ColumnSchema('categoryId', 'TEXT NOT NULL'),
      ColumnSchema('type', 'TEXT NOT NULL'),
      ColumnSchema('amount', 'REAL NOT NULL'),
      ColumnSchema('description', 'TEXT'),
      ColumnSchema('date', 'INTEGER NOT NULL'),
      ColumnSchema('isRecurring', 'INTEGER DEFAULT 0'),
      ColumnSchema('recurringPattern', 'TEXT'),
      ColumnSchema('notes', 'TEXT'),
      ColumnSchema('latitude', 'REAL'),
      ColumnSchema('longitude', 'REAL'),
      ColumnSchema('receipt', 'TEXT'),
      ColumnSchema('createdAt', 'INTEGER NOT NULL'),
      ColumnSchema('updatedAt', 'INTEGER NOT NULL'),
      ColumnSchema('FOREIGN KEY(userId)', 'REFERENCES users(id) ON DELETE CASCADE'),
      ColumnSchema('FOREIGN KEY(accountId)', 'REFERENCES accounts(id) ON DELETE CASCADE'),
      ColumnSchema('FOREIGN KEY(categoryId)', 'REFERENCES categories(id) ON DELETE CASCADE'),
    ],
  );
  
  static final TableSchema _budgetsTable = TableSchema(
    name: tableBudgets,
    columns: [
      ColumnSchema('id', 'TEXT PRIMARY KEY'),
      ColumnSchema('userId', 'TEXT NOT NULL'),
      ColumnSchema('categoryId', 'TEXT NOT NULL'),
      ColumnSchema('limit', 'REAL NOT NULL'),
      ColumnSchema('period', 'TEXT NOT NULL'),
      ColumnSchema('alertThreshold', 'REAL DEFAULT 80'),
      ColumnSchema('startDate', 'INTEGER NOT NULL'),
      ColumnSchema('endDate', 'INTEGER'),
      ColumnSchema('isActive', 'INTEGER DEFAULT 1'),
      ColumnSchema('createdAt', 'INTEGER NOT NULL'),
      ColumnSchema('updatedAt', 'INTEGER NOT NULL'),
      ColumnSchema('FOREIGN KEY(userId)', 'REFERENCES users(id) ON DELETE CASCADE'),
      ColumnSchema('FOREIGN KEY(categoryId)', 'REFERENCES categories(id) ON DELETE CASCADE'),
    ],
  );
  
  static final TableSchema _goalsTable = TableSchema(
    name: tableGoals,
    columns: [
      ColumnSchema('id', 'TEXT PRIMARY KEY'),
      ColumnSchema('userId', 'TEXT NOT NULL'),
      ColumnSchema('name', 'TEXT NOT NULL'),
      ColumnSchema('targetAmount', 'REAL NOT NULL'),
      ColumnSchema('currentAmount', 'REAL DEFAULT 0'),
      ColumnSchema('deadline', 'INTEGER NOT NULL'),
      ColumnSchema('priority', 'TEXT NOT NULL'),
      ColumnSchema('category', 'TEXT'),
      ColumnSchema('description', 'TEXT'),
      ColumnSchema('icon', 'TEXT'),
      ColumnSchema('color', 'TEXT'),
      ColumnSchema('isCompleted', 'INTEGER DEFAULT 0'),
      ColumnSchema('createdAt', 'INTEGER NOT NULL'),
      ColumnSchema('updatedAt', 'INTEGER NOT NULL'),
      ColumnSchema('FOREIGN KEY(userId)', 'REFERENCES users(id) ON DELETE CASCADE'),
    ],
  );
  
  static final TableSchema _transactionTagsTable = TableSchema(
    name: tableTransactionTags,
    columns: [
      ColumnSchema('id', 'TEXT PRIMARY KEY'),
      ColumnSchema('transactionId', 'TEXT NOT NULL'),
      ColumnSchema('tag', 'TEXT NOT NULL'),
      ColumnSchema('createdAt', 'INTEGER NOT NULL'),
      ColumnSchema('FOREIGN KEY(transactionId)', 'REFERENCES transactions(id) ON DELETE CASCADE'),
    ],
  );
  
  static final TableSchema _attachmentsTable = TableSchema(
    name: tableAttachments,
    columns: [
      ColumnSchema('id', 'TEXT PRIMARY KEY'),
      ColumnSchema('transactionId', 'TEXT NOT NULL'),
      ColumnSchema('filePath', 'TEXT NOT NULL'),
      ColumnSchema('fileType', 'TEXT NOT NULL'),
      ColumnSchema('uploadedAt', 'INTEGER NOT NULL'),
      ColumnSchema('FOREIGN KEY(transactionId)', 'REFERENCES transactions(id) ON DELETE CASCADE'),
    ],
  );
}

class TableSchema {
  final String name;
  final List<ColumnSchema> columns;
  
  TableSchema({
    required this.name,
    required this.columns,
  });
  
  String toCreateTableSQL() {
    final columnDefinitions = columns.join(', ');
    return 'CREATE TABLE IF NOT EXISTS $name ($columnDefinitions)';
  }
}

class ColumnSchema {
  final String name;
  final String type;
  
  ColumnSchema(this.name, this.type);
  
  @override
  String toString() => '$name $type';
}
