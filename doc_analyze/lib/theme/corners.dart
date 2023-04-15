import 'package:flutter/material.dart';

class Corners{
  static const double btn = s5;
  static const double dialog = 12;
  /// Xs
  static const double s3 = 3;
  static BorderRadius get s3Border => BorderRadius.all(s3Radius);
  static Radius get s3Radius => const Radius.circular(s3);
  /// Small
  static const double s5 = 5;
  static BorderRadius get s5Border => BorderRadius.all(s5Radius);
  static Radius get s5Radius => const Radius.circular(s5);
  /// Medium
  static const double s8 = 8;
  static const BorderRadius s8Border = BorderRadius.all(s8Radius);
  static const Radius s8Radius = Radius.circular(s8);
  /// Large
  static const double s10 = 10;
  static BorderRadius get s10Border => BorderRadius.all(s10Radius);
  static Radius get s10Radius => const Radius.circular(s10);
}