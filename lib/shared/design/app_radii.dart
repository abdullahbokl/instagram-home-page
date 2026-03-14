import 'package:flutter/widgets.dart';

abstract final class AppRadii {
  static const small = Radius.circular(4);
  static const medium = Radius.circular(8);
  static const large = Radius.circular(14);

  static const card = BorderRadius.all(medium);
  static const pill = BorderRadius.all(large);
}
