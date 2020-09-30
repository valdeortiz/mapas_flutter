import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/models/traffic_response.dart';

class TrafficService {
  TrafficService._privateConstructor();
  static final TrafficService _istance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _istance;
  }

  final _dio = new Dio();
  final baseUrl = 'https://api.mapbox.com/directions/v5';
  final apiKey =
      'pk.eyJ1IjoidmFsZGVvcnRpeiIsImEiOiJja2Zwbm9tc3QwYmxkMzFtdXR6dGgzemFzIn0.TbWgSJC8S1tlRVmBE78aJA';

  Future<DrivingResponse> getCoordsInicioYDestino(
      LatLng inicio, LatLng destino) async {
    print('inicio: $inicio');
    print('destino: $destino');
    final coordString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${this.baseUrl}/mapbox/driving/$coordString';
    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this.apiKey,
      'language': 'es',
    });

    final data = DrivingResponse.fromJson(resp.data);

    return data;
  }
}
