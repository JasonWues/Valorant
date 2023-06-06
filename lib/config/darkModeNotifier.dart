// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeNotifier extends StateNotifier<int> {
  late SharedPreferences prefs;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    var darkMode = prefs.getInt("darkMode");
    state = darkMode ?? 0;
  }

  DarkModeNotifier() : super(0) {
    _init();
  }

  void toggle(int index) async {
    state = index;
    await prefs.setInt("darkMode", index);
  }
}
