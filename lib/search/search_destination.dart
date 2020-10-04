import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/models/search_response.dart';
import 'package:mapas_app/models/search_results.dart';
import 'package:mapas_app/services/trafic_services.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximidad;
  final List<SearchResult> historial;
  SearchDestination(this.proximidad, this.historial)
      : this.searchFieldLabel = 'Buscar...',
        this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this.close(context, SearchResult(cancelo: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return this._construirResultadoSugerencias();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Colocar ubicacion manual'),
            onTap: () {
              this.close(context, SearchResult(cancelo: false, manual: true));
            },
          ),
          ...this
              .historial
              .map(
                (result) => ListTile(
                  leading: Icon(Icons.history),
                  title: Text(result.nombreDestino),
                  subtitle: Text(result.description),
                  onTap: () {
                    this.close(context, result);
                  },
                ),
              )
              .toList()
        ],
      );
    }
    return this._construirResultadoSugerencias();
  }

  Widget _construirResultadoSugerencias() {
    if (this.query.length == 0) {
      return Container();
    }
    this._trafficService.getSugerenciasPorQuery(this.query.trim(), proximidad);
    return StreamBuilder(
      stream: this._trafficService.sugerenciaStream,
      // .getResultadosPorQuery(this.query.trim(), proximidad),
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final lugares = snapshot.data.features;

        if (lugares.length == 0) {
          return ListTile(
            title: Text('No se encontraron resultados con $query'),
          );
        }

        return ListView.separated(
          itemCount: lugares.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (_, i) {
            final lugar = lugares[i];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(lugar.textEs),
              subtitle: Text(lugar.placeNameEs),
              onTap: () {
                this.close(
                  context,
                  SearchResult(
                    cancelo: false,
                    manual: false,
                    position: LatLng(lugar.center[1], lugar.center[0]),
                    nombreDestino: lugar.textEs,
                    description: lugar.placeNameEs,
                  ),
                );
                // en mapbox viene primero la longitud y despes la latitud mientras en maps es lati long
              },
            );
          },
        );
      },
    );
  }
}
