import 'dart:async';

import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singlentonScanBloc = new ScansBloc._internal();

  factory ScansBloc() {
    return _singlentonScanBloc;
  }
  ScansBloc._internal() {
    // Obtener Scans de la Base de dato
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }
}
