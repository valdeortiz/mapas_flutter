import 'dart:convert';

DrivingResponse drivingResponseFromJson(String str) =>
    DrivingResponse.fromJson(json.decode(str));

String drivingResponseToJson(DrivingResponse data) =>
    json.encode(data.toJson());

class DrivingResponse {
  DrivingResponse({
    this.routes,
    this.waypoints,
    this.code,
    this.uuid,
  });

  List<Route> routes;
  List<Waypoint> waypoints;
  String code;
  String uuid;

  factory DrivingResponse.fromJson(Map<String, dynamic> json) =>
      DrivingResponse(
        routes: json["routes"] == null
            ? null
            : List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
        waypoints: json["waypoints"] == null
            ? null
            : List<Waypoint>.from(
                json["waypoints"].map((x) => Waypoint.fromJson(x))),
        code: json["code"] == null ? null : json["code"],
        uuid: json["uuid"] == null ? null : json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "routes": routes == null
            ? null
            : List<dynamic>.from(routes.map((x) => x.toJson())),
        "waypoints": waypoints == null
            ? null
            : List<dynamic>.from(waypoints.map((x) => x.toJson())),
        "code": code == null ? null : code,
        "uuid": uuid == null ? null : uuid,
      };
}

class Route {
  Route({
    this.weightName,
    this.weight,
    this.duration,
    this.distance,
    this.legs,
    this.geometry,
  });

  String weightName;
  double weight;
  double duration;
  double distance;
  List<Leg> legs;
  String geometry;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        weightName: json["weight_name"] == null ? null : json["weight_name"],
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        legs: json["legs"] == null
            ? null
            : List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        geometry: json["geometry"] == null ? null : json["geometry"],
      );

  Map<String, dynamic> toJson() => {
        "weight_name": weightName == null ? null : weightName,
        "weight": weight == null ? null : weight,
        "duration": duration == null ? null : duration,
        "distance": distance == null ? null : distance,
        "legs": legs == null
            ? null
            : List<dynamic>.from(legs.map((x) => x.toJson())),
        "geometry": geometry == null ? null : geometry,
      };
}

class Leg {
  Leg({
    this.steps,
    this.admins,
    this.duration,
    this.distance,
    this.weight,
    this.summary,
  });

  List<dynamic> steps;
  List<Admin> admins;
  double duration;
  double distance;
  double weight;
  String summary;

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        steps: json["steps"] == null
            ? null
            : List<dynamic>.from(json["steps"].map((x) => x)),
        admins: json["admins"] == null
            ? null
            : List<Admin>.from(json["admins"].map((x) => Admin.fromJson(x))),
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        summary: json["summary"] == null ? null : json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "steps": steps == null ? null : List<dynamic>.from(steps.map((x) => x)),
        "admins": admins == null
            ? null
            : List<dynamic>.from(admins.map((x) => x.toJson())),
        "duration": duration == null ? null : duration,
        "distance": distance == null ? null : distance,
        "weight": weight == null ? null : weight,
        "summary": summary == null ? null : summary,
      };
}

class Admin {
  Admin({
    this.iso31661Alpha3,
    this.iso31661,
  });

  String iso31661Alpha3;
  String iso31661;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        iso31661Alpha3: json["iso_3166_1_alpha3"] == null
            ? null
            : json["iso_3166_1_alpha3"],
        iso31661: json["iso_3166_1"] == null ? null : json["iso_3166_1"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1_alpha3": iso31661Alpha3 == null ? null : iso31661Alpha3,
        "iso_3166_1": iso31661 == null ? null : iso31661,
      };
}

class Waypoint {
  Waypoint({
    this.distance,
    this.name,
    this.location,
  });

  double distance;
  String name;
  List<double> location;

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        name: json["name"] == null ? null : json["name"],
        location: json["location"] == null
            ? null
            : List<double>.from(json["location"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance == null ? null : distance,
        "name": name == null ? null : name,
        "location": location == null
            ? null
            : List<dynamic>.from(location.map((x) => x)),
      };
}
