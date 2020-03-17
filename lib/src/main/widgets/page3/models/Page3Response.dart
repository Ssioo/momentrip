class Page3Response {
  bool isSuccess;
  int code;
  String message;
  Page3Result result;

  Page3Response.fromJson(Map<String, dynamic> json)
      : isSuccess = json['isSuccess'],
        code = json['code'],
        message = json['message'],
        result = Page3Result.fromJson(json['result']);

  Map<String, dynamic> toJson() => {
    'isSuccess' : isSuccess,
    'code' : code,
    'message' : message,
    'result' : result.toJson()
  };
}

class Page3Result {
  int tripCount;
  int countryCount;
  int cityCount;

  Page3Result.fromJson(Map<String, dynamic> json)
      : tripCount = json['tripCount'],
        countryCount = json['countryCount'],
        cityCount = json['cityCount'];

  Map<String, dynamic> toJson() => {
        'tripCount': tripCount,
        'countryCount': countryCount,
        'cityCount': cityCount
      };
}
