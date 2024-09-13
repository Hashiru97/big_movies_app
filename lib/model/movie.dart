import 'config.dart';
import '../model/app_provider.dart';

class Movie {
  final int? id;
  final String? name;
  final String? language;
  final bool? isAdult;
  final String? description;
  final String? posterPath;
  final String? backdropPath;
  final num? rating;
  final String? releaseDate;
  final List<Provider>? providers; // List of providers

  Movie({
    this.id,
    this.name,
    this.language,
    this.isAdult,
    this.description,
    this.posterPath,
    this.backdropPath,
    this.rating,
    this.releaseDate,
    this.providers,
  });

  // Factory constructor to create Movie instance from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    // Check if 'providers' exists and is a list, map it to the Provider objects
    List<Provider>? providersList;
    if (json['providers'] != null && json['providers'] is List) {
      providersList = (json['providers'] as List)
          .map((provider) => Provider.fromJson(provider))
          .toList();
    }

    return Movie(
      id: json['id'],
      name: json['title'],
      language: json['original_language'],
      isAdult: json['adult'],
      description: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      rating: json['vote_average'],
      releaseDate: json['release_date'],
      providers: providersList, // Assign the mapped providers
    );
  }

  // Getter for the poster URL
  String get posterURL {
    return '${Config.baseImageApiUrl}w500$posterPath';
  }
}
