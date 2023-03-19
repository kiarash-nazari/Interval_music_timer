  import 'package:dio/dio.dart';

class SizeFinder {
  final Dio _dio = Dio();
  final CancelToken _cancelToken = CancelToken();

  Future<int> getFileSize(String url) async {
            // Response head = await _dio.head(url);
            // // int contentLength = head.headers['content-length'] != null
            // // ? int.parse(head.headers['content-length']![0])
            // // : -1;
            
    Response response = await _dio.head(url);
    return int.parse(response.headers.map['content-length']![0]);
  }
}