import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangNotifier extends StateNotifier<String> {
  late SharedPreferences prefs;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    var lang = prefs.getString("lang");
    state = lang ?? "";
  }

  LangNotifier() : super("") {
    _init();
  }

  void change(String lang) async {
    state = lang;
    await prefs.setString("lang", lang);
  }
}
