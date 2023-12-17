import 'package:ebook/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DatabaseHelper {
  static final _dbName = "myDatabase.db";
  static final _dbVersion = 2;
  static final _tableName = "users";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + _dbName;
    return await openDatabase(path,
        version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY,
            fullname TEXT,
            phone TEXT,
            address TEXT,
            username TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL
          )
          ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle your database upgrade logic here
    if (oldVersion < 2) {
      // Add new columns for version 2
      await db.execute('ALTER TABLE $_tableName ADD COLUMN fullname TEXT');
      await db.execute('ALTER TABLE $_tableName ADD COLUMN phone TEXT');
      await db.execute('ALTER TABLE $_tableName ADD COLUMN address TEXT');
    }
    // Handle further upgrades if _dbVersion increases in the future
  }

  // Add user to database
  Future<int> addUser(User user) async {
    Database db = await instance.database;
    return await db.insert(_tableName, user.toMap());
  }

  // Authenticate user
  Future<User?> authenticateUser(String username, String password) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(_tableName,
        columns: [
          "id",
          "fullname",
          "phone",
          "address",
          "username",
          "email",
          "password"
        ],
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);
    if (maps.isNotEmpty) {
      return User(
        id: maps.first["id"],
        fullname: maps.first["fullname"],
        phone: maps.first["phone"],
        address: maps.first["address"],
        username: maps.first["username"],
        email: maps.first["email"],
        password: maps.first["password"],
      );
    }
    return null;
  }

  // Logout function
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs
        .remove('username'); // Remove other session-related data if needed
    await prefs
        .remove('fullname'); // Remove other session-related data if needed
    await prefs.remove('email'); // Remove other session-related data if needed

    // Add any other logout-related functionality here
  }

  // Check if user exists
  Future<bool> userExists(String username, String email) async {
    Database db = await instance.database;
    List<Map> user = await db.query(
      _tableName,
      where: 'username = ? OR email = ?',
      whereArgs: [username, email],
    );
    return user.isNotEmpty;
  }

  // Delete user account
  Future<void> deleteUser(String username) async {
    Database db = await instance.database;
    await db.delete(
      _tableName,
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  Future<bool> updateUser(String oldUsername, String? newUsername,
      String? newEmail, String? oldPassword, String? newPassword) async {
    Database db = await instance.database;

    // Preparing the data for update
    Map<String, dynamic> updateData = {};
    if (newUsername != null && newUsername.isNotEmpty) {
      updateData['username'] = newUsername;
    }
    if (newEmail != null && newEmail.isNotEmpty) {
      updateData['email'] = newEmail;
    }

    if (oldPassword != null &&
        newPassword != null &&
        oldPassword.isNotEmpty &&
        newPassword.isNotEmpty &&
        oldPassword != newPassword) {
      // Check if the old password is correct
      List<Map> result = await db.query(
        _tableName,
        where: 'username = ? AND password = ?',
        whereArgs: [oldUsername, oldPassword],
      );

      if (result.isNotEmpty) {
        updateData['password'] =
            newPassword; // Consider hashing the new password
      } else {
        // Old password is incorrect
        return false;
      }
    }

    if (updateData.isNotEmpty) {
      // Perform the update
      await db.update(
        _tableName,
        updateData,
        where: 'username = ?',
        whereArgs: [oldUsername],
      );
      return true;
    }

    return false;
  }
}
