import 'package:flutter/cupertino.dart';
import 'package:momentrip/src/common/models/DefaultResponse.dart';

abstract class MainView {

  void validateSuccess(BuildContext buildContext, DefaultResponse defaultResponse);
  void validateFailure(BuildContext buildContext);
}