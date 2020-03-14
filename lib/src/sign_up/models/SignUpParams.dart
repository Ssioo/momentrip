class SignUpParams {
  String userEmail;
  String userPw;
  String userName;
  String userBirth;

  SignUpParams({this.userEmail, this.userPw, this.userName, this.userBirth});

  SignUpParams.fromJson(Map<String, dynamic> json) :
        userEmail = json['userEmail'],
        userPw = json['userPw'],
        userName = json['userName'],
        userBirth = json['userBirth'];

  Map<String, dynamic> toJson() => {
    'userEmail' : userEmail,
    'userPw' : userPw,
    'userName' : userName,
    'userBirth' : userBirth
  };
}