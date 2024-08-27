import 'package:get_it/get_it.dart';

import '../services/http_service.dart';

class MovieService {
  final getIt = GetIt.instance;

  late HttpService _httpService;

  MovieService() {
    _httpService = getIt.get<HttpService>();
  }
}
