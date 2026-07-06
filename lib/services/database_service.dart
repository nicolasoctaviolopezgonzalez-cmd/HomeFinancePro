import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:home_finance_pro/config/database_config.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  late Database _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final fullPath = path.join(dbPath, DatabaseConfig.databaseName);

    return await openDatabase(
      fullPath,
      version: DatabaseConfig.databaseVersion,
      onCreate: (db, version) async {
        for (final table in DatabaseConfig.tables) {
          await db.execute(table.toCreateTableSQL());
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (final table in DatabaseConfig.tables) {
          await db.execute(table.toCreateTableSQL());
        }
      },
    );
  }

  Future<void> closeDatabase() async {
    await _database.close();
  }

  // User operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(DatabaseConfig.tableUsers, user);
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    final db = await database;
    final result = await db.query(
      DatabaseConfig.tableUsers,
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateUser(String userId, Map<String, dynamic> user) async {
    final db = await database;
    return await db.update(
      DatabaseConfig.tableUsers,
      user,
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  // Account operations
  Future<int> insertAccount(Map<String, dynamic> account) async {
    final db = await database;
    return await db.insert(DatabaseConfig.tableAccounts, account);
  }

  Future<List<Map<String, dynamic>>> getAccountsByUser(String userId) async {
    final db = await database;
    return await db.query(
      DatabaseConfig.tableAccounts,
      where: 'userId = ? AND isActive = 1',
      whereArgs: [userId],
    );
  }

  Future<int> updateAccount(String accountId, Map<String, dynamic> account) async {
    final db = await database;
    return await db.update(
      DatabaseConfig.tableAccounts,
      account,
      where: 'id = ?',
      whereArgs: [accountId],
    );
  }

  Future<int> deleteAccount(String accountId) async {
    final db = await database;
    return await db.delete(
      DatabaseConfig.tableAccounts,
      where: 'id = ?',
      whereArgs: [accountId],
    );
  }

  // Category operations
  Future<int> insertCategory(Map<String, dynamic> category) async {
    final db = await database;
    return await db.insert(DatabaseConfig.tableCategories, category);
  }

  Future<List<Map<String, dynamic>>> getCategoriesByUser(String userId) async {
    final db = await database;
    return await db.query(
      DatabaseConfig.tableCategories,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<int> updateCategory(String categoryId, Map<String, dynamic> category) async {
    final db = await database;
    return await db.update(
      DatabaseConfig.tableCategories,
      category,
      where: 'id = ?',
      whereArgs: [categoryId],
    );
  }

  Future<int> deleteCategory(String categoryId) async {
    final db = await database;
    return await db.delete(
      DatabaseConfig.tableCategories,
      where: 'id = ?',
      whereArgs: [categoryId],
    );
  }

  // Transaction operations
  Future<int> insertTransaction(Map<String, dynamic> transaction) async {
    final db = await database;
    return await db.insert(DatabaseConfig.tableTransactions, transaction);
  }

  Future<List<Map<String, dynamic>>> getTransactionsByUser(
    String userId, {
    int limit = 50,
    int offset = 0,
  }) async {
    final db = await database;
    return await db.query(
      DatabaseConfig.tableTransactions,
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
      limit: limit,
      offset: offset,
    );
  }

  Future<List<Map<String, dynamic>>> getTransactionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final db = await database;
    return await db.query(
      DatabaseConfig.tableTransactions,
      where: 'userId = ? AND date >= ? AND date <= ?',
      whereArgs: [
        userId,
        startDate.millisecondsSinceEpoch,
        endDate.millisecondsSinceEpoch,
      ],
      orderBy: 'date DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getTransactionsByCategory(
    String categoryId, {
    int limit = 50,
    int offset = 0,
  }) async {
    final db = await database;
    return await db.query(
      DatabaseConfig.tableTransactions,
      where: 'categoryId = ?',
      whereArgs: [categoryId],
      orderBy: 'date DESC',
      limit: limit,
      offset: offset,
    );
  }

  Future<int> updateTransaction(String transactionId, Map<String, dynamic> transaction) async {
    final db = await database;
    return await db.update(
      DatabaseConfig.tableTransactions,
      transaction,
      where: 'id = ?',
      whereArgs: [transactionId],
    );
  }

  Future<int> deleteTransaction(String transactionId) async {
    final db = await database;
    return await db.delete(
      DatabaseConfig.tableTransactions,
      where: 'id = ?',
      whereArgs: [transactionId],
    );
  }

  // Budget operations
  Future<int> insertBudget(Map<String, dynamic> budget) async {
    final db = await database;
    return await db.insert(DatabaseConfig.tableBudgets, budget);
  }

  Future<List<Map<String, dynamic>>> getBudgetsByUser(String userId) async {
    final db = await database;
    return await db.query(
      DatabaseConfig.tableBudgets,
      where: 'userId = ? AND isActive = 1',
      whereArgs: [userId],
    );
  }

  Future<int> updateBudget(String budgetId, Map<String, dynamic> budget) async {
    final db = await database;
    return await db.update(
      DatabaseConfig.tableBudgets,
      budget,
      where: 'id = ?',
      whereArgs: [budgetId],
    );
  }

  Future<int> deleteBudget(String budgetId) async {
    final db = await database;
    return await db.delete(
      DatabaseConfig.tableBudgets,
      where: 'id = ?',
      whereArgs: [budgetId],
    );
  }

  // Goal operations
  Future<int> insertGoal(Map<String, dynamic> goal) async {
    final db = await database;
    return await db.insert(DatabaseConfig.tableGoals, goal);
  }

  Future<List<Map<String, dynamic>>> getGoalsByUser(String userId) async {
    final db = await database;
    return await db.query(
      DatabaseConfig.tableGoals,
      where: 'userId = ? AND isCompleted = 0',
      whereArgs: [userId],
      orderBy: 'deadline ASC',
    );
  }

  Future<int> updateGoal(String goalId, Map<String, dynamic> goal) async {
    final db = await database;
    return await db.update(
      DatabaseConfig.tableGoals,
      goal,
      where: 'id = ?',
      whereArgs: [goalId],
    );
  }

  Future<int> deleteGoal(String goalId) async {
    final db = await database;
    return await db.delete(
      DatabaseConfig.tableGoals,
      where: 'id = ?',
      whereArgs: [goalId],
    );
  }

  Future<double> getTotalExpensesByCategory(String categoryId, DateTime startDate, DateTime endDate) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM ${DatabaseConfig.tableTransactions} WHERE categoryId = ? AND type = ? AND date >= ? AND date <= ?',
      [categoryId, 'Gasto', startDate.millisecondsSinceEpoch, endDate.millisecondsSinceEpoch],
    );
    if (result.isNotEmpty && result[0]['total'] != null) {
      return (result[0]['total'] as num).toDouble();
    }
    return 0.0;
  }

  Future<double> getTotalIncome(String userId, DateTime startDate, DateTime endDate) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM ${DatabaseConfig.tableTransactions} WHERE userId = ? AND type = ? AND date >= ? AND date <= ?',
      [userId, 'Ingreso', startDate.millisecondsSinceEpoch, endDate.millisecondsSinceEpoch],
    );
    if (result.isNotEmpty && result[0]['total'] != null) {
      return (result[0]['total'] as num).toDouble();
    }
    return 0.0;
  }

  Future<double> getTotalExpense(String userId, DateTime startDate, DateTime endDate) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM ${DatabaseConfig.tableTransactions} WHERE userId = ? AND type = ? AND date >= ? AND date <= ?',
      [userId, 'Gasto', startDate.millisecondsSinceEpoch, endDate.millisecondsSinceEpoch],
    );
    if (result.isNotEmpty && result[0]['total'] != null) {
      return (result[0]['total'] as num).toDouble();
    }
    return 0.0;
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete(DatabaseConfig.tableTransactionTags);
    await db.delete(DatabaseConfig.tableAttachments);
    await db.delete(DatabaseConfig.tableTransactions);
    await db.delete(DatabaseConfig.tableBudgets);
    await db.delete(DatabaseConfig.tableGoals);
    await db.delete(DatabaseConfig.tableCategories);
    await db.delete(DatabaseConfig.tableAccounts);
    await db.delete(DatabaseConfig.tableUsers);
  }
}
