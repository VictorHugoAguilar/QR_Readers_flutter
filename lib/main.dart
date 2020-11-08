import 'package:flutter/material.dart';
import 'package:qrreader/src/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
      },
      theme: _myTheme(),
    );
  }

  ThemeData _myTheme() {
    return ThemeData(primaryColor: Colors.blueGrey);
  }
}
