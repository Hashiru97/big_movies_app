class TVShow {
  final int? id;
  final String? name;
  final String? language;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final num? rating;
  final String? firstAirDate;
  final String? originCountry;
  final double? voteAverage;

  TVShow({
    this.id,
    this.name,
    this.language,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.rating,
    this.firstAirDate,
    this.originCountry,
    this.voteAverage,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      id: json['id'],
      name: json['name'] ?? json['original_name'],
      language: json['original_language'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      rating: json['vote_average'],
      firstAirDate: json['first_air_date'],
      originCountry: json['origin_country'] != null &&
              (json['origin_country'] as List).isNotEmpty
          ? (json['origin_country'][0] as String)
          : '',
    );
  }

  String get posterURL {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }
}
