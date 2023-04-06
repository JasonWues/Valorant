import 'package:flutter/material.dart';

final brightness =
    WidgetsBinding.instance.platformDispatcher.platformBrightness;

final primaryColor = brightness == Brightness.light
    ? const Color.fromRGBO(103, 80, 164, 1.0)
    : const Color.fromRGBO(207, 188, 255, 1.0);

final backgroundColor = brightness == Brightness.light
    ? const Color.fromRGBO(255, 251, 255, 1.0)
    : const Color.fromRGBO(28, 27, 31, 1.0);
