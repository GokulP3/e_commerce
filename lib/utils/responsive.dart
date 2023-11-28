import 'package:flutter/material.dart';

class Responsive {
  BuildContext context;

  Responsive._(this.context);

  Responsive(this.context);

  double get width => MediaQuery.of(context).size.width;

  double get height => MediaQuery.of(context).size.height;

  double get fontResponsive => MediaQuery.of(context).textScaleFactor;
}
