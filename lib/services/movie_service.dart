import 'package:get_it/get_it.dart';
import '../services/http_service.dart';
import '../model/tv_show.dart';
import '../model/movie.dart';

class MovieService {
  final getIt = GetIt.instance;
  late final HttpService _httpService;

  MovieService() {
    _httpService = getIt.get<HttpService>();
  }

  // Fetch popular movies
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

  // Fetch upcoming movies
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

  // Search for movies
  Future<List<Movie>> searchMovies(
      {required String query, required int page}) async {
    try {
      final response = await _httpService.get('/search/movie', query: {
        'query': query,
        'page': page,
      });

      List<Movie> movies = (response.data['results'] as List)
          .map<Movie>((movieData) => Movie.fromJson(movieData))
          .toList();
      return movies;
    } catch (e) {
      throw Exception('Error occurred while searching movies: $e');
    }
  }

  // Fetch latest movie
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

  // Fetch Now Playing Movies
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

  // Fetch top-rated movies
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
      throw Exception('Error occurred while fetching top-rated movies: $e');
    }
  }

  // Fetch airing today TV shows
  Future<List<TVShow>> getAiringTodayTVShows({required int page}) async {
    try {
      final response = await _httpService.get('/tv/airing_today', query: {
        'page': page,
      });

      return (response.data['results'] as List)
          .map((tvShowData) => TVShow.fromJson(tvShowData))
          .toList();
    } catch (e) {
      throw Exception(
          'Error occurred while fetching airing today TV shows: $e');
    }
  }

  // Fetch on-the-air TV shows
  Future<List<TVShow>> getOnTheAirTVShows({required int page}) async {
    try {
      final response = await _httpService.get('/tv/on_the_air', query: {
        'page': page,
      });

      return (response.data['results'] as List)
          .map((tvShowData) => TVShow.fromJson(tvShowData))
          .toList();
    } catch (e) {
      throw Exception('Error occurred while fetching on-the-air TV shows: $e');
    }
  }

  // Fetch popular TV shows
  Future<List<TVShow>> getPopularTVShows({required int page}) async {
    try {
      final response = await _httpService.get('/tv/popular', query: {
        'page': page,
      });

      return (response.data['results'] as List)
          .map((tvShowData) => TVShow.fromJson(tvShowData))
          .toList();
    } catch (e) {
      throw Exception('Error occurred while fetching popular TV shows: $e');
    }
  }

  // Fetch top-rated TV shows
  Future<List<TVShow>> getTopRatedTVShows({required int page}) async {
    try {
      final response = await _httpService.get('/tv/top_rated', query: {
        'page': page,
      });

      return (response.data['results'] as List)
          .map((tvShowData) => TVShow.fromJson(tvShowData))
          .toList();
    } catch (e) {
      throw Exception('Error occurred while fetching top-rated TV shows: $e');
    }
  }

  // Search TV Shows (new function)
  Future<List<TVShow>> searchTVShows(
      {required String query, required int page}) async {
    try {
      final response = await _httpService.get('/search/tv', query: {
        'query': query,
        'page': page,
      });

      return (response.data['results'] as List)
          .map((tvShowData) => TVShow.fromJson(tvShowData))
          .toList();
    } catch (e) {
      throw Exception('Error occurred while searching TV shows: $e');
    }
  }
}
