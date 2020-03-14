class SignInParams {
  String userEmail;
  String userPw;

  SignInParams({this.userEmail, this.userPw});

  SignInParams.fromJson(Map<String, dynamic> json) :
        userEmail = json['userEmail'],
        userPw = json['userPw'];

  Map<String, dynamic> toJson() => {
    'userEmail' : userEmail,
    'userPw' : userPw
  };
}