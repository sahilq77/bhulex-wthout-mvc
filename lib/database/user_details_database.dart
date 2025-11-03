import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabaseHelper {
  static final UserDatabaseHelper _instance = UserDatabaseHelper._internal();
  static Database? _database;

  factory UserDatabaseHelper() => _instance;

  UserDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user (
            id TEXT PRIMARY KEY,
            customer_name TEXT,
            mobile_number TEXT,
            email TEXT,
            village_id TEXT,
            taluka_id TEXT,
            state_id TEXT,
            pincode TEXT
          )
        ''');
      },
    );
  }

  // Store user data
  Future<void> storeUser(Map<String, dynamic> userData) async {
    final db = await database;
    await db.insert(
      'user',
      {
        'id': userData['id'],
        'customer_name': userData['customer_name'],
        'mobile_number': userData['mobile_number'],
        'email': userData['email'],
        'village_id': userData['village_id'],
        'taluka_id': userData['taluka_id'],
        'state_id': userData['state_id'],
        'pincode': userData['pincode'],
      },
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Replace if user already exists
    );
  }

  // Get user data
  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.query('user', limit: 1); // Single user
    return result.isNotEmpty ? result.first : null;
  }

  // Clear user data
  Future<void> clearUser() async {
    final db = await database;
    await db.delete('user');
  }

  // Close database (optional, call when app closes if needed)
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
