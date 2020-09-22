import 'package:flutter/material.dart';
import 'package:mapas_app/helpers/helpers.dart';
import 'package:mapas_app/pages/acceso_gps_page.dart';
import 'package:mapas_app/pages/mapa_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: this.checkGpsLocation(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Center(
                child: Container(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              );
            }));
  }

  Future checkGpsLocation(BuildContext context) async {
    // TODO: permiso gps
    // TODO: gps activo
    await Future.delayed(Duration(microseconds: 100));

    Navigator.pushReplacement(
        context, navegarMapaFadeIn(context, AccesoGpsPage()));
    // context, navegarMapaFadeIn(context, MapaPage()));
  }
}
