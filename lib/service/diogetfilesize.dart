  import 'package:dio/dio.dart';

class SizeFinder {
  final Dio _dio = Dio();
  Future<int> getFileSize(String url) async {         
    Response response = await _dio.head(url);
    return int.parse(response.headers.map['content-length']![0]);
  }
}