import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('person_banco.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    //TABELA USUARIO
    await db.execute('''
      CREATE TABLE usuario(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        idade INTEGER NOT NULL,
        altura REAL NOT NULL,
        sexo TEXT NOT NULL,
        peso REAL NOT NULL,
        objetivo TEXT,
        caloriasDiarias INTEGER,
        aguaDiaria REAL 
      )
    ''');
    //TABELA REFEICOES
    await db.execute('''
      CREATE TABLE refeicoes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        calorias INTEGER NOT NULL,
        data DATETIME NOT NULL
      )
    ''');
    //TABELA AGUA CONSUMIDA
    await db.execute('''
    CREATE TABLE agua_consumida(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      quantidade REAL NOT NULL,
      data DATETIME NOT NULL
    )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
