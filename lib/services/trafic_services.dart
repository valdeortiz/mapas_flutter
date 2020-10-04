import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/helpers/debouncer.dart';
import 'package:mapas_app/models/traffic_response.dart';
import 'package:mapas_app/models/search_response.dart';

class TrafficService {
  TrafficService._privateConstructor();
  static final TrafficService _istance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _istance;
  }

  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 400));
  final StreamController<SearchResponse> _sugerenciasStreamController =
      StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get sugerenciaStream =>
      this._sugerenciasStreamController.stream;
  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey =
      'pk.eyJ1IjoidmFsZGVvcnRpeiIsImEiOiJja2Zwbm9tc3QwYmxkMzFtdXR6dGgzemFzIn0.TbWgSJC8S1tlRVmBE78aJA';

  Future<DrivingResponse> getCoordsInicioYDestino(
      LatLng inicio, LatLng destino) async {
    print('inicio: $inicio');
    print('destino: $destino');
    final coordString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${this._baseUrlDir}/mapbox/driving/$coordString';
    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this._apiKey,
      'language': 'es',
    });

    final data = DrivingResponse.fromJson(resp.data);

    return data;
  }

  Future<SearchResponse> getResultadosPorQuery(
      String busqueda, LatLng proximidad) async {
    print("buscando !!!!");
    final url = '${this._baseUrlGeo}/mapbox.places/$busqueda.json';
    try {
      final resp = await this._dio.get(url, queryParameters: {
        'access_token': this._apiKey,
        'autocomplete': 'true',
        'proximity': '${proximidad.longitude},${proximidad.latitude}',
        'language': 'es',
      });

      final data = resp.data;

      return searchResponseFromJson(data);
    } catch (e) {
      return SearchResponse(features: []);
    }
  }

  void getSugerenciasPorQuery(String busqueda, LatLng proximidad) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await this.getResultadosPorQuery(value, proximidad);
      this._sugerenciasStreamController.add(resultados);
    };
    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });
    Future.delayed(Duration(milliseconds: 201)).then((value) => timer.cancel());
  }
}
