// lib/services/http_service.dart
import 'package:dio/dio.dart';

import '../model/config.dart';
import 'package:logger/logger.dart';

class HttpService {
  final Dio dio = Dio();
  final Logger logger = Logger();

  HttpService() {
    dio.options.baseUrl = Config.baseApiUrl;
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      final response = await dio.get(path, queryParameters: {
        'api_key': Config.apiKey,
        'language': 'en-US',
        ...?query,
      });
      logger.i('GET Request to $path with query $query');
      return response;
    } on DioException catch (e) {
      logger.e('Dio error occurred: $e');
      throw Exception('Failed to perform GET request: ${e.message}');
    }
  }
}
