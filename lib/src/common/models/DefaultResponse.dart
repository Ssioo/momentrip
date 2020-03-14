
class DefaultResponse {
  bool isSuccess;
  int code;
  String message;

  DefaultResponse({this.isSuccess, this.code, this.message});

  DefaultResponse.fromJson(Map<String, dynamic> json) :
        isSuccess = json['isSuccess'],
        code = json['code'],
        message = json['message'];

  Map<String, dynamic> toJson() => {
    'isSuccess' : isSuccess,
    'code' : code,
    'message' : message
  };
}