# QR-READER

Proyecto de aplicación para escaneos de códigos QR, utilizando la cámara del dispositivo,
luego insertandolos en BDLite para llevar un historico, en el cual podemos modificar, eliminar uno
especifico o todos los historicos.
La lectura de códigos podrán ser URLs, o Geoubicaciones que nos ubicarán en un mapa.

## Capturas




## Depencencias utilizadas y configuraciones especificas

- [barcode_scanner 1.0.1](https://pub.dev/packages/barcode_scanner)

    ````
        dependencies:
            barcode_scanner: ^1.0.1
    ````

Para dispositivos ios seguir las siguientes instrucciones

Ir a: IOS->FLUTTER->APP.FRAMEWORK->INFO.PLIST
Asegurarse que en nuestro RUNNER PROYECT en general esta la versión mínima en 9.0 dentro del XCODE

Asegurarse de esto:

<key>MinimumOSVersion</key>
<string>9.0</string>  

Until this is fixed in CocoaPods, you can add the following to your Podfile as a workaround:

    ````
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
            config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
            end
        end
    end
    ````

- [sqflite 1.3.2+1](https://pub.dev/packages/sqflite)

    ````
       dependencies:
            sqflite: ^1.3.0
    ````

- [path_provider 1.6.24](https://pub.dev/packages/path_provider)

    ````
      dependencies:
            path_provider: ^1.6.24
    ````

- [url_launcher 5.7.10](https://pub.dev/packages/url_launcher)

    ````
     dependencies:
        url_launcher: ^5.7.10
    ````

- [flutter_map: ^0.10.1+1](https://pub.dev/packages/flutter_map)

    ````
     dependencies:
        flutter_map: ^0.10.1+1
    ````
    

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# QR_Readers_flutter
