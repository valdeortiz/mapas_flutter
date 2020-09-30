import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class SearchResult {
  @required
  final bool cancelo;
  final bool manual;
  final LatLng position;
  final String nombreDestino;
  final String description;

  SearchResult(
      {this.cancelo,
      this.manual,
      this.position,
      this.nombreDestino,
      this.description});
}
