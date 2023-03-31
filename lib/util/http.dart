import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
      queryParameters: {"language": "zh-CN"},
      sendTimeout: const Duration(seconds: 6)),
);

class ValorantClientApi {
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
