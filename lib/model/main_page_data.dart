import './movie.dart';
import './tv_show.dart';
import './search_category.dart';

class MainPageData {
  final List<Movie>? movies;
  final List<TVShow>? tvShows;
  final int? page;
  final String? searchCategory;
  final String? searchText;

  MainPageData({
    this.movies,
    this.tvShows,
    this.page,
    this.searchCategory,
    this.searchText,
  });

  MainPageData.initial()
      : movies = [],
        tvShows = [],
        page = 1,
        searchCategory = SearchCategory.popular,
        searchText = '';

  MainPageData copyWith({
    List<Movie>? movies,
    List<TVShow>? tvShows,
    int? page,
    String? searchCategory,
    String? searchText,
  }) {
    return MainPageData(
      movies: movies ?? this.movies,
      tvShows: tvShows ?? this.tvShows,
      page: page ?? this.page,
      searchCategory: searchCategory ?? this.searchCategory,
      searchText: searchText ?? this.searchText,
    );
  }
}
