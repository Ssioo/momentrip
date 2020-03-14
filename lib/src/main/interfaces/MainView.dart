import 'package:momentrip/src/main/models/MainResponse.dart';

abstract class MainView {

  void validateSuccess(MainResponse mainResponse);
  void validateFailure();
}