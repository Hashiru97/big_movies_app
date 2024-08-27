import '../model/config.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class HttpService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;
  final Logger logger = Logger();

  late String baseUrl;
  late String apiKey;

  HttpService() {
    AppConfig config = getIt.get<AppConfig>();
    baseUrl = config.baseApiUrl;
    apiKey = config.apiKey;
  }

  Future<Response?> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$baseUrl$path';
      Map<String, dynamic> queryParameters = {
        'api_key': apiKey,
        'language': 'en-US',
      };
      if (query != null) {
        queryParameters.addAll(query);
      }
      return await dio.get(url, queryParameters: queryParameters);
    } on DioException catch (e) {
      logger.e('Unable to perform get request.', e);
      return null;
    }
    // In case of failure, return an empty response or handle it as needed
    catch (e, stackTrace) {
      logger.e('Unexpected error during GET request', e, stackTrace);
      return null;
    }
  }
}
