class MainResponse {
  bool isSuccess;
  int code;
  String message;
  List<MainResult> mainResult;

  MainResponse.fromJson(Map<String, dynamic> json)
      : isSuccess = json['isSuccess'],
        code = json['code'],
        message = json['message'],
        mainResult = json['result'] == null ? null : (json['result'] as List)
            .map((e) => MainResult.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'isSuccess': isSuccess,
        'code': code,
        'message': message,
        'result': mainResult
      };
}

class MainResult {
  int tripIdx;
  String title;
  String startedAt;
  String endedAt;


  MainResult({this.tripIdx, this.title, this.startedAt, this.endedAt});

  MainResult.fromJson(Map<String, dynamic> json)
      : tripIdx = json['tripIdx'],
        title = json['title'],
        startedAt = json['startedAt'],
        endedAt = json['endedAt'];

  Map<String, dynamic> toJson() =>
      {
        'tripIdx': tripIdx,
        'title': title,
        'startedAt': startedAt,
        'endedAt': endedAt
      };
}

class MainObjectResponse {
  bool isSuccess;
  int code;
  String message;
  MainResult mainResult;

  MainObjectResponse.fromJson(Map<String, dynamic> json)
      : isSuccess = json['isSuccess'],
        code = json['code'],
        message = json['message'],
        mainResult = MainResult.fromJson(json['result']);

  Map<String, dynamic> toJson() => {
        'isSuccess': isSuccess,
        'code': code,
        'message': message,
        'result': mainResult
      };
}
