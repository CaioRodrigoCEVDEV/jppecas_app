import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/produto.dart';

class DBService {
  static Future<Database> _db() async {
    final path = join(await getDatabasesPath(), 'produtos.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE produtos(
            procod INTEGER PRIMARY KEY,
            tipodes TEXT,
            marcasdes TEXT,
            prodes TEXT,
            provl REAL
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> salvarProdutos(List<Produto> produtos) async {
    final db = await _db();
    await db.delete('produtos');
    for (var p in produtos) {
      await db.insert('produtos', p.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  static Future<List<Produto>> buscarProdutos() async {
    final db = await _db();
    final maps = await db.query('produtos');
    return maps.map((m) => Produto.fromJson(m)).toList();
  }
}