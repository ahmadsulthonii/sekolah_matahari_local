import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sekolah_matahari_local/data_siswa_model.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'siswamatahari.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'Create table siswamatahari (idSiswa text primary key, namaSiswa text, kelas text)',
        );
      },
    );
  }

  Future<int> insertSiswa(DataSiswaModel siswamt) async {
    final dbsis = await database;
    return await dbsis.insert(
      'siswamatahari',
      siswamt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DataSiswaModel>> getSiswaMt() async {
    final dbsis = await database;
    final List<Map<String, dynamic>> maps = await dbsis.query('siswamatahari');
    return maps.map((data) => DataSiswaModel.fromMap(data)).toList();
  }

  Future<int> updateSiswaMt(DataSiswaModel siswamt) async {
    final dbsis = await database;
    return await dbsis.update(
      'siswamatahari',
      siswamt.toMap(),
      where: 'idSiswa=?',
      whereArgs: [siswamt.idSiswa],
    );
  }

  Future<int> deleteSiswaMt(String idSiswa) async {
    final dbsis = await database;
    return await dbsis.delete(
      'siswamatahari',
      where: 'idSiswa = ?',
      whereArgs: [idSiswa],
    );
  }
}
