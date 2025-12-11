import 'package:flutter/widgets.dart';

class AppDecoration {
  AppDecoration._();

  static get searchShadow => const BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.1), // #00000026 = 15.7% opacity black
        offset: Offset(0, 4), // x: 0, y: 4
        blurRadius: 19,
        spreadRadius: 0,
      );
}
