import 'package:flutter/cupertino.dart';
import '../models/MainResponse.dart';

abstract class MainView {

  void validateSuccess(BuildContext buildContext, MainObjectResponse mainObjectResponse);
  void validateFailure(BuildContext buildContext);

  void validateStatusSuccess(BuildContext buildContext, MainResponse mainResponse);
  void validateStatusFailure(BuildContext buildContext);
}