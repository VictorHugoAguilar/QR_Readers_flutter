import 'dart:io';
import 'package:path/path.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  // Inicializar la BD
  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE Scans ( id INTEGER PRIMARY KEY, '
            ' tipo TEXT, valor TEXT )');
      },
    );
  }

  // Crear registros
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final db = await database;

    final result = await db.rawInsert("INSERT INTO Scans (id, tipo, valor) "
        "VALUES(  ${nuevoScan.id},  '${nuevoScan.tipo}' ,  '${nuevoScan.valor}' )");

    return result;
  }

  // Enviando un mapa al insert
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;

    final result = await db.insert('Scans', nuevoScan.toJson());

    return result;
  }

  // Select - Obtener información
  Future<ScanModel> getScanId(int id) async {
    final db = await database;

    final respuesta = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return respuesta.isNotEmpty ? ScanModel.fromJson(respuesta.first) : null;
  }

  Future<List<ScanModel>> getTodosScans() async {
    final db = await database;

    final respuesta = await db.query('Scans');

    List<ScanModel> list = respuesta.isNotEmpty
        ? respuesta.map((sc) => ScanModel.fromJson(sc)).toList()
        : [];

    return list;
  }

  Future<List<ScanModel>> getScansTipo(String tipo) async {
    final db = await database;

    final respuesta =
        await db.rawQuery("SELECT * FROM Scans where tipo = '$tipo'");

    List<ScanModel> list = respuesta.isNotEmpty
        ? respuesta.map((sc) => ScanModel.fromJson(sc)).toList()
        : [];

    return list;
  }

  // Actualizar registros
  Future<int> updateScan(ScanModel scanNuevo) async {
    final db = await database;

    final result = await db.update('Scans', scanNuevo.toJson(),
        where: 'id= ?', whereArgs: [scanNuevo.id]);

    return result;
  }

  // Eliminar registro
  Future<int> deleteScan(int id) async {
    final db = await database;

    final result = await db.delete('Scans', where: 'id=?', whereArgs: [id]);

    return result;
  }

  // Eliminar toda la tabla de registros
  Future<int> deleteAll() async {
    final db = await database;

    final result = await db.rawDelete('DELETE FROM Scans');

    return result;
  }

  // fin class DBProvider
}
