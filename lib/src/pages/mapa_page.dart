import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:qrreader/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController mapController = new MapController();
  String tipoMapa = 'streets-v11';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapController.move(scan.getLatLng(), 15);
            },
          ),
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context, scan),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10,
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/styles/v1/{style}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoidmljdG9ydXVnbyIsImEiOiJja2hhZ3l6dXIxY2R5MnpsMmVtYm16cm1sIn0.B83pb3kE2Y8g_n2CF6NKaA',
          'style': 'mapbox/$tipoMapa',
          //  'id': 'mapbox.streets',
          //'style': 'mapbox/streets-v11'
          // 'style': 'mapbox/outdoors-v11',
          //  'style': 'mapbox/light-v10'
          //  'style': 'mapbox/dark-v10'
          // 'style': 'mapbox/satellite-v9'
          //  'style': 'mapbox/satellite-streets-v11'
        });
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 60.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }

  Widget _crearBotonFlotante(BuildContext context, ScanModel scan) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        if (tipoMapa == 'streets-v11') {
          tipoMapa = 'outdoors-v11';
        } else if (tipoMapa == 'outdoors-v11') {
          tipoMapa = 'light-v10';
        } else if (tipoMapa == 'light-v10') {
          tipoMapa = 'satellite-streets-v11';
        } else if (tipoMapa == 'satellite-streets-v11') {
          tipoMapa = 'dark-v10';
        } else if (tipoMapa == 'dark-v10') {
          tipoMapa = 'streets-v11';
        }
        // refrescamos el state
        setState(() {});

        //movimiento #1 al maximo de zoom
        mapController.move(scan.getLatLng(), 30);

        //Regreso al Zoom Deseado después de unos Milisegundos
        Future.delayed(Duration(milliseconds: 50), () {
          mapController.move(scan.getLatLng(), 15);
        });
      },
    );
  }
}
