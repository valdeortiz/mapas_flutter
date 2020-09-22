import 'package:flutter/material.dart';
import 'package:mapas_app/pages/acceso_gps_page.dart';
import 'package:mapas_app/pages/loading_page.dart';
import 'package:mapas_app/pages/mapa_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
      routes: {
        'mapa': (_) => MapaPage(),
        'loading': (_) => LoadingPage(),
        'acceso_gps': (_) => AccesoGpsPage(),
      },
    );
  }
}
