import 'package:flutter/material.dart';
import 'package:qrreader/src/models/scan_model.dart';

import 'package:qrreader/src/pages/direcciones_page.dart';
import 'package:qrreader/src/pages/mapas_page.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreader/src/providers/db_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: _callPage(currentIndex),
      appBar: _crearAppBar(),
      bottomNavigationBar: _crearBottomNavigatorBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _crearActionButton(),
    );
    return scaffold;
  }

  Widget _crearBottomNavigatorBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          // ignore: deprecated_member_use
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          // ignore: deprecated_member_use
          title: Text('Direcciones'),
        ),
      ],
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPages();
      case 1:
        return DireccionesPage();
      default:
        return MapasPages();
    }
  }

  Widget _crearAppBar() {
    return AppBar(
      title: Text('QR Scanner'),
      actions: [
        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _crearActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: _scanQR,
    );
  }

  _scanQR() async {
    /*
    ScanResult futureString = null;

    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      e.toString();
    }
    // http://google.es
    // https://maps.google.com/local?q=38.36376322466995,-0.4383241540832672

    String resultado = futureString.rawContent;

    print('future string: $resultado');

    if (futureString != null) {
      print('Tenemos información');
    }

    */

    String futureString =
        'https://maps.google.com/local?q=38.36376322466995,-0.4383241540832672';

    if (futureString != null) {
      final scan = ScanModel(valor: futureString);

      DBProvider.db.nuevoScan(scan);
    }
  }
}
