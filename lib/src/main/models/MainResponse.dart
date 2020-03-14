
class MainResponse {
  bool isSuccess;
  int code;
  String message;

  MainResponse({this.isSuccess, this.code, this.message});

  MainResponse.fromJson(Map<String, dynamic> json) :
        isSuccess = json['isSuccess'],
        code = json['code'],
        message = json['message'];

  Map<String, dynamic> toJson() => {
    'isSuccess' : isSuccess,
    'code' : code,
    'message' : message
  };
}