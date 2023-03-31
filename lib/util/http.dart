import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

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

  Future<dynamic> valorantDownload(String url, String name) async {
    final filepath = await FilePicker.platform.getDirectoryPath();
    final response = await dio.download(url, "$filepath$name.jpg");
  }
}
