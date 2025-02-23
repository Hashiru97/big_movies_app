import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/main_page_data.dart';
import '../model/movie.dart';
import '../model/tv_show.dart';
import '../model/search_category.dart';
import '../services/movie_service.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController() : super(MainPageData.initial()) {
    fetchMoviesOrTVShows();
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> fetchMoviesOrTVShows() async {
    try {
      List<Movie> movies = [];
      List<TVShow> tvShows = [];

      if ((state.searchText ?? '').isNotEmpty) {
        if (state.searchCategory?.contains("TV Shows") ?? false) {
          tvShows = await _movieService.searchTVShows(
            query: state.searchText!,
            page: state.page!,
          );
        } else {
          movies = await _movieService.searchMovies(
            query: state.searchText!,
            page: state.page!,
          );
        }
      } else if (state.searchCategory == SearchCategory.popular) {
        movies = await _movieService.getPopularMovies(page: state.page!);
      } else if (state.searchCategory == SearchCategory.upcoming) {
        movies = await _movieService.getUpcomingMovies(page: state.page!);
      } else if (state.searchCategory == SearchCategory.latest) {
        movies = await _movieService.getLatestMovie();
      } else if (state.searchCategory == SearchCategory.nowPlaying) {
        movies = await _movieService.getNowPlayingMovies(page: state.page!);
      } else if (state.searchCategory == SearchCategory.topRated) {
        movies = await _movieService.getTopRatedMovies(page: state.page!);
      } else if (state.searchCategory == SearchCategory.tvAiringToday) {
        tvShows = await _movieService.getAiringTodayTVShows(page: state.page!);
      } else if (state.searchCategory == SearchCategory.tvOnTheAir) {
        tvShows = await _movieService.getOnTheAirTVShows(page: state.page!);
      } else if (state.searchCategory == SearchCategory.tvPopular) {
        tvShows = await _movieService.getPopularTVShows(page: state.page!);
      } else if (state.searchCategory == SearchCategory.tvTopRated) {
        tvShows = await _movieService.getTopRatedTVShows(page: state.page!);
      }

      state = state.copyWith(
        movies: [...?state.movies, ...movies],
        tvShows: [...?state.tvShows, ...tvShows],
        page: (state.page ?? 1) + 1,
      );
    } catch (e) {
      // Handle errors appropriately
    }
  }

  void updateSearchText(String searchText) {
    if (searchText.isEmpty) {
      updateSearchCategory(state.searchCategory ?? SearchCategory.popular);
    } else {
      state = state.copyWith(
        searchText: searchText,
        page: 1,
        movies: [],
        tvShows: [],
      );
      fetchMoviesOrTVShows();
    }
  }

  void updateSearchCategory(String searchCategory) {
    state = state.copyWith(
      searchCategory: searchCategory,
      page: 1,
      movies: [],
      tvShows: [],
      searchText: '', // Clear the search text
    );
    fetchMoviesOrTVShows();
  }
}
