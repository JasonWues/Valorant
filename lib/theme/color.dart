import 'package:flutter/material.dart';

final brightness =
    WidgetsBinding.instance.platformDispatcher.platformBrightness;
final Color bluePrimaryColor = brightness == Brightness.light
    ? const Color.fromRGBO(0, 97, 164, 1.0)
    : const Color.fromRGBO(159, 202, 255, 1.0);
