import 'package:flutter/material.dart';
import '../models/Page3Response.dart';

abstract class Page3View {
  void validateSuccess(BuildContext context, Page3Response page3response);
  void validateFailure(BuildContext context);
}