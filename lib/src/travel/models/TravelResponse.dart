class TravelResponse {
  bool isSuccess;
  int code;
  String message;
  List<TravelResult> travelList;

  TravelResponse.fromJson(Map<String, dynamic> json)
      : isSuccess = json['isSuccess'],
        code = json['code'],
        message = json['message'],
        travelList = json['result'] == null ? null : (json['result'] as List)
            .map((e) => TravelResult.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
    'isSuccess': isSuccess,
    'code': code,
    'message': message,
    'result': travelList
  };
}

class TravelResult {
  int videoIdx;
  int category;
  String thumbnailUrl;
  String videoUrl;
  String videoText;
  String address;
  double lat;
  double lng;
  int day;
  String createdAt;

  TravelResult.fromJson(Map<String, dynamic> json)
      : videoIdx = json['videoIdx'],
        category = json['categoryIdx'],
        thumbnailUrl = json['thumnail'],
        videoUrl = json['videoLink'],
        videoText = json['videoText'],
        address = json['address'],
        lat = json['latitude'],
        lng = json['longitude'],
        day = json['days'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() => {
    'videoIdx': videoIdx,
    'categoryIdx': category,
    'thumbnail': thumbnailUrl,
    'videoLink': videoUrl,
    'videoText': videoText,
    'address': address,
    'lat': lat,
    'lng': lng,
    'days': day,
    'createdAt': createdAt
  };
}
