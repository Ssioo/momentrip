class Page1Response {
  bool isSuccess;
  int code;
  String message;
  List<Page1Result> result;

  Page1Response.fromJson(Map<String, dynamic> json)
      : isSuccess = json['isSuccess'],
        code = json['code'],
        message = json['message'],
        result = (json['result'] as List).map((e) => Page1Result.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
    'isSuccess' : isSuccess,
    'code' : code,
    'message' : message,
    'result' : result
  };
}

class Page1Result {
  int tripIdx;
  String title;
  String tripImgUrl;
  String country;
  String city;
  String date;
  String year;

  Page1Result.fromJson(Map<String, dynamic> json)
      : tripIdx = json['tripIdx'],
        title = json['title'],
        tripImgUrl = json['tripImg'],
        country = json['country'],
        city = json['city'],
        date = json['date'],
        year = json['year'];

  Map<String, dynamic> toJson() => {
    'tripIdx' : tripIdx,
    'title' : title,
    'tripImg' : tripImgUrl,
    'country' : country,
    'city' : city,
    'date' : date,
    'year' : year
  };
}