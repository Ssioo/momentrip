import 'package:flutter/cupertino.dart';
import 'package:momentrip/src/common/models/DefaultResponse.dart';

abstract class SplashView {
  void validateSuccess(BuildContext context, DefaultResponse response);
  void validateFailure(BuildContext context);
}