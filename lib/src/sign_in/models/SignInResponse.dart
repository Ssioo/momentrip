
class SignInResponse {
  bool isSuccess;
  int code;
  String message;
  SignInResult result;

  SignInResponse.fromJson(Map<String, dynamic> json) :
        isSuccess = json['isSuccess'],
        code = json['code'],
        message = json['message'],
        result = SignInResult.fromJson(json['result']);

  Map<String, dynamic> toJson() => {
    'isSuccess' : isSuccess,
    'code' : code,
    'message' : message,
    'result' : result
  };


}

class SignInResult {
  String token;
  int userInfoIdx;

  SignInResult.fromJson(Map<String, dynamic> json) :
      token = json['token'],
      userInfoIdx = json['userInfoIdx'];

  Map<String, dynamic> toJson() => {
    'token' : token,
    'userInfoIdx' : userInfoIdx
  };
}