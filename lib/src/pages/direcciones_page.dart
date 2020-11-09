import 'package:flutter/material.dart';
import 'package:qrreader/src/bloc/scan_bloc.dart';
import 'package:qrreader/src/models/scan_model.dart';

import 'package:qrreader/src/utils/utils.dart' as utils;

class DireccionesPage extends StatelessWidget {
  final scanBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scanBloc.obtenerScans();
    return StreamBuilder<List<ScanModel>>(
      // future: DBProvider.db.getTodosScans(),
      stream: scanBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(
            child: Text('No hay datos'),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            direction: DismissDirection.endToStart,
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              child: Row(
                children: [
                  SizedBox(
                    width: 300.0,
                  ),
                  Text(
                    'Eliminar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                  Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ],
              ),
            ),
            onDismissed: (direction) => {
              if (direction == DismissDirection.endToStart)
                //DBProvider.db.deleteScan(scans[i].id),
                scanBloc.borrarScan(scans[i].id),
            },
            child: ListTile(
              leading: Icon(
                Icons.cloud_queue,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scans[i].valor),
              subtitle: Text('ID: ${scans[i].id.toString()}'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: () => utils.abrirScan(context, scans[i]),
            ),
          ),
        );
      },
    );
  }
}
