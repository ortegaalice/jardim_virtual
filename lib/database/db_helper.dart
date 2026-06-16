import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String caminho = join(
      await getDatabasesPath(),
      'jardim_virtual.db',
    );

    return await openDatabase(
      caminho,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE plantas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        especie TEXT NOT NULL,
        dataAquisicao TEXT NOT NULL,
        local TEXT NOT NULL,
        foto TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE cuidados(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        plantaId INTEGER NOT NULL,
        tipo TEXT NOT NULL,
        data TEXT NOT NULL,
        observacoes TEXT NOT NULL
      )
    ''');
  }

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE plantas ADD COLUMN foto TEXT',
      );
    }
  }
}