import 'package:flutter/cupertino.dart';
import 'package:momentrip/src/common/models/DefaultResponse.dart';

abstract class SignUpView {
  validateSuccess(BuildContext context, DefaultResponse response);
  validateFailure(BuildContext context);
}