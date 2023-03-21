import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
      queryParameters: {"language": "zh-CN"},
      baseUrl: "https://valorant-api.com",
      sendTimeout: const Duration(seconds: 6)),
);

class ValorantClientApi {
  Future<dynamic> valorantGet(String url) async {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      return response.data;
    }
  }
}
