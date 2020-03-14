import 'package:flutter/cupertino.dart';
import 'package:momentrip/src/sign_in/models/SignInParams.dart';
import 'package:momentrip/src/sign_in/models/SignInResponse.dart';

abstract class SignInView {
  void validateSuccess(BuildContext context, SignInResponse signInResponse);
  void validateFailure(BuildContext context);
}