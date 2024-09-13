import 'package:get_it/get_it.dart';
import '../services/http_service.dart';
import '../model/app_provider.dart';
import '../model/movie.dart';

class MovieService {
  final getIt = GetIt.instance;
  late final HttpService _httpService;

  MovieService() {
    _httpService = getIt.get<HttpService>();
  }

  // Fetch popular movies and ensure each movie has an id
  Future<List<Movie>> getPopularMovies({required int page}) async {
    try {
      final response = await _httpService.get('/movie/popular', query: {
        'page': page,
      });

      List<Movie> movies = (response.data['results'] as List)
          .map<Movie>((movieData) => Movie.fromJson(movieData))
          .toList();

      return movies;
    } catch (e) {
      throw Exception('Error occurred while fetching popular movies: $e');
    }
  }

  Future<List<Movie>> getUpcomingMovies({required int page}) async {
    try {
      final response = await _httpService.get('/movie/upcoming', query: {
        'page': page,
      });

      List<Movie> movies = (response.data['results'] as List)
          .map<Movie>((movieData) => Movie.fromJson(movieData))
          .toList();
      return movies;
    } catch (e) {
      throw Exception('Error occurred while fetching upcoming movies: $e');
    }
  }

  Future<List<Movie>> searchMovies(
      {required String query, required int page}) async {
    try {
      final response = await _httpService.get('/search/movie', query: {
        'query': query,
        'page': page,
        'include_adult': false,
      });

      List<Movie> movies = (response.data['results'] as List)
          .map<Movie>((movieData) => Movie.fromJson(movieData))
          .toList();
      return movies;
    } catch (e) {
      throw Exception('Error occurred while searching movies: $e');
    }
  }

  Future<List<Movie>> getLatestMovie() async {
    try {
      final response = await _httpService.get('/movie/latest');

      if (response.statusCode == 200) {
        Movie movie = Movie.fromJson(response.data);
        return [movie];
      } else {
        throw Exception('Failed to load latest movie');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching the latest movie: $e');
    }
  }

  Future<List<Movie>> getNowPlayingMovies({required int page}) async {
    try {
      final response = await _httpService.get('/movie/now_playing', query: {
        'page': page,
      });

      List<Movie> movies = (response.data['results'] as List)
          .map<Movie>((movieData) => Movie.fromJson(movieData))
          .toList();
      return movies;
    } catch (e) {
      throw Exception('Error occurred while fetching now playing movies: $e');
    }
  }

  Future<List<Movie>> getTopRatedMovies({required int page}) async {
    try {
      final response = await _httpService.get('/movie/top_rated', query: {
        'page': page,
      });

      List<Movie> movies = (response.data['results'] as List)
          .map<Movie>((movieData) => Movie.fromJson(movieData))
          .toList();
      return movies;
    } catch (e) {
      throw Exception('Error occurred while fetching top rated movies: $e');
    }
  }

  Future<List<Provider>> getWatchProviders(int movieId) async {
    try {
      final response =
          await _httpService.get('/movie/$movieId/watch/providers');
      final providersData =
          response.data['results']['US'] ?? {}; // Adjust for your region

      List<Provider> providers = [];
      if (providersData['free'] != null) {
        providers = (providersData['free'] as List)
            .map<Provider>((providerData) => Provider.fromJson(providerData))
            .toList();
      } else if (providersData['buy'] != null) {
        providers = (providersData['buy'] as List)
            .map<Provider>((providerData) => Provider.fromJson(providerData))
            .toList();
      }
      return providers;
    } catch (e) {
      throw Exception('Error occurred while fetching watch providers: $e');
    }
  }

  // Method to get movie embed URL using TMDB ID
  Future<String> getMovieEmbedUrl({required String tmdbId}) async {
    final embedUrl = 'https://vidsrc.xyz/embed/movie?tmdb=$tmdbId';
    return embedUrl; // Return the constructed embed URL for the movie
  }

  // Method to get TV show embed URL using TMDB ID
  Future<String> getTvEmbedUrl(
      {required String tmdbId,
      required int season,
      required int episode}) async {
    final embedUrl =
        'https://vidsrc.xyz/embed/tv?tmdb=$tmdbId&season=$season&episode=$episode';
    return embedUrl; // Return the constructed embed URL for the TV show
  }
}
