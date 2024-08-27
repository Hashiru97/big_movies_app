import 'package:get_it/get_it.dart';
import 'package:big/model/config.dart';

class Movie {
  final String name;
  final String language;
  final bool isAdult;
  final String description;
  final String posterPath;
  final String backdropPath;
  final num rating;
  final String release;

  Movie({
    required this.name,
    required this.language,
    required this.isAdult,
    required this.description,
    required this.posterPath,
    required this.backdropPath,
    required this.rating,
    required this.release,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['original_title'],
      language: json['original_language'],
      isAdult: json['adult'],
      description: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      rating: json['vote_average'],
      release: json['release_date'],
    );
  }

  String posterURL() {
    final AppConfig appConfig = GetIt.instance.get<AppConfig>();
    return '${appConfig.baseImageApiUrl}${posterPath}';
  }
}
