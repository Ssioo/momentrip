class CameraResultResponse {

}

class CameraGeoCodedResponse {
  GeoCoded_Plus plus_code;

  CameraGeoCodedResponse.fromJson(Map<String, dynamic> json) :
  plus_code = GeoCoded_Plus.fromJson(json['plus_code']);
  Map<String, dynamic> toJson() => {
    'plus_code' : plus_code.toJson()
  };
}

class GeoCoded_Plus {
  String compound_code;
  String global_code;

  GeoCoded_Plus.fromJson(Map<String, dynamic> json) :
  compound_code = json['compound_code'],
  global_code = json['global_code']
  ;
  Map<String, dynamic> toJson() => {
    'compound_code' : compound_code,
    'global_code' : global_code
  };
}

class GeoCoded_Result {
  List<GeoCoded_Result_Address> address_components;
  String status;

  GeoCoded_Result.fromJson(Map<String, dynamic> json) :
  address_components = (json['address_components'] as List).map((e) => GeoCoded_Result_Address.fromJson(e)),
  status = json['status'];

  Map<String, dynamic> toJson() => {
    'address_components' : address_components.toList(),
    'status' : status
  };
}

class GeoCoded_Result_Address {
  List<GeoCoded_Result_Address_Component> address_components;
  String formatted_address;
  GeoCoded_Result_Address_Geometry geometry;
  String place_id;
  GeoCoded_Plus plus_code;
  List<String> types;

  GeoCoded_Result_Address.fromJson(Map<String, dynamic> json) :
  address_components = (json['address_components'] as List).map((e) => GeoCoded_Result_Address_Component.fromJson(e)),
  formatted_address = json['formatted_address'],
  geometry = GeoCoded_Result_Address_Geometry.fromJson(json['geometry']),
  place_id = json['place_id'],
  plus_code = GeoCoded_Plus.fromJson(json['plus_code']),
  types = List<String>.from(json['types'])
  ;
  Map<String, dynamic> toJson() => {
    'address_components' : address_components,
    'formatted_address' : formatted_address,
    'geometry' : geometry.toJson(),
    'place_id' : place_id,
    'plus_code' : plus_code.toJson(),
    'types' : types
  };
}

class GeoCoded_Result_Address_Component {
  String long_name;
  String short_name;
  List<String> types;
  

  GeoCoded_Result_Address_Component.fromJson(Map<String, dynamic> json) :
      long_name = json['long_name'],
  short_name = json['short_name'],
  types = List<String>.from(json['types']);

  Map<String, dynamic> toJson() => {
    'long_name' : long_name,
    'short_name' : short_name,
    'types' : types.toList()
  };
}

class GeoCoded_Result_Address_Geometry {
  Geometry_LatLng location;
  String location_type;
  Geometry_ViewPort viewport;

  GeoCoded_Result_Address_Geometry.fromJson(Map<String, dynamic> json) :
      location = Geometry_LatLng.fromJson(json['location']),
  location_type = json['location_type'],
  viewport = Geometry_ViewPort.fromJson(json['viewport'])
  ;
  Map<String, dynamic> toJson() => {
    'location' : location.toJson(),
    'location_type' : location_type,
    'viewport' : viewport.toJson()
  };
}

class Geometry_LatLng {
  String lat;
  String lng;

  Geometry_LatLng.fromJson(Map<String, dynamic> json) :
  lat = json['lat'], lng = json['lng'];

  Map<String, dynamic> toJson() => {
    'lat' : lat,
    'lng' : lng
  };
}

class Geometry_ViewPort {
  Geometry_LatLng northeast;
  Geometry_LatLng southwest;

  Geometry_ViewPort(this.northeast, this.southwest);

  Geometry_ViewPort.fromJson(Map<String, dynamic> json) :
        northeast = Geometry_LatLng.fromJson(json['northeast']),
  southwest = Geometry_LatLng.fromJson(json['southwest']);
  Map<String, dynamic> toJson() => {
    'northeast' : northeast.toJson(),
    'southwest' : southwest.toJson()
  };
}
