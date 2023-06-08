import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefs = SharedPreferences.getInstance();

final dio = Dio(
  BaseOptions(sendTimeout: const Duration(seconds: 6)),
);

class ValorantClientApi {
  late SharedPreferences prefs;

  ValorantClientApi() {
    _init();
  }

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    var lang = prefs.getString("lang");

    dio.options.queryParameters.addAll({"language": lang});
  }

  Future<dynamic> valorantGet(String url) async {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      return response.data;
    }
  }

  Future<dynamic> valorantDownload(String url, String fileName) async {
    return await dio.download(url, fileName);
  }
}
