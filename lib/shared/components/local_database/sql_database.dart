import 'package:lamassu/shared/components/local_database/base_database.dart';
import 'package:lamassu/shared/components/local_database/models/account.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class SqlDatabase extends BaseDatabase {
  static Database? _productDb;
  static SqlDatabase? _sqlDatabase;

  SqlDatabase._createInstance();

  static final SqlDatabase db = SqlDatabase._createInstance();

  factory SqlDatabase() {
    _sqlDatabase ??= SqlDatabase._createInstance();
    return _sqlDatabase!;
  }

  Future<Database> get database async {
    _productDb ??= await initializeDatabase();
    return _productDb!;
  }

  Future<Database> initializeDatabase() async {
    var directory = await getDatabasesPath();
    String path = p.join(directory, 'rawanComplex.db');
    var myDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return myDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE accounts (_id INT ,token VARCHAR(255) NOT NULL,name VARCHAR(255) ,phone VARCHAR(20) ,type VARCHAR(20) ,email VARCHAR(255) PRIMARY KEY,center_id VARCHAR(255))',
    );
  }

  @override
  Future deleteAccount(String email) async {
    final database = await this.database;
    await database.delete('accounts', where: 'email = ?', whereArgs: [email]);
  }

  @override
  Future<Account?> getAccount(String email) async {
    final database = await this.database;
    var result = await database
        .query('accounts', where: 'email = ?', whereArgs: [email]);
    return result.firstOrNull == null ? null : Account.fromJson(result.first);
  }

  @override
  Future<List<Account>> getAllAccount() async {
    final database = await this.database;
    var result = await database.query('accounts');
    return result.map((e) {
      print(e['email']);
      return Account.fromJson(e);
    }).toList();
  }

  Future<void> updateUser(
      String email, Map<String, dynamic> updatedData) async {
    final database = await this.database;
    await database.update(
      'accounts',
      updatedData,
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  @override
  Future insertAccountAsMap(Map<String, dynamic> account) async {
    final user = {
      'token': account['token'],
      '_id': account['_id'],
      'name': account['name'],
      'phone': account['phone'],
      'type': account['type'],
      'email': account['email'],
      'center_id': account['center_id'],
    };
    final database = await this.database;
    var result = await database
        .query('accounts', where: 'email = ?', whereArgs: [user['email']]);
    if (result.isEmpty) {
      await database.insert('accounts', user);
    } else {
      await database.update('accounts', user,
          where: 'email = ?', whereArgs: [user['email']]);
    }
  }

  @override
  Future insertAccount(Account account) async {
    final database = await this.database;
    var result = await database
        .query('accounts', where: 'email = ?', whereArgs: [account.email]);
    if (result.isEmpty) {
      await database.insert('accounts', account.toJson());
    } else {
      await database.update('accounts', account.toJson(),
          where: 'email = ?', whereArgs: [account.email]);
    }
  }

  @override
  close() async {
    var db = await database;
    var result = db.close();
    return result;
  }
}
