import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/search_category.dart';
import '../model/movie.dart';
import '../model/main_page_data.dart';
import '../widgets/movie_tile.dart';
import '../controllers/main_page_data_controller.dart';
import '../pages/movie_details_page.dart'; // Import Movie Details Page

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>(
        (ref) => MainPageDataController());

final selectedMoviePosterURLProvider = StateProvider<String?>((ref) {
  final movies = ref.watch(mainPageDataControllerProvider).movies;
  return (movies?.isNotEmpty ?? false) ? movies![0].posterURL : null;
});

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  late TextEditingController _searchTextFieldController;
  String? _selectedMoviePosterURL;

  @override
  void initState() {
    super.initState();
    _searchTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainPageData = ref.watch(mainPageDataControllerProvider);
    final mainPageDataController =
        ref.read(mainPageDataControllerProvider.notifier);
    _selectedMoviePosterURL = ref.watch(selectedMoviePosterURLProvider);

    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          height: deviceHeight,
          width: deviceWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _backgroundWidget(deviceHeight, deviceWidth),
              _foregroundWidgets(
                deviceHeight,
                deviceWidth,
                mainPageDataController,
                mainPageData,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backgroundWidget(double deviceHeight, double deviceWidth) {
    if (_selectedMoviePosterURL != null) {
      return Container(
        height: deviceHeight,
        width: deviceWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(_selectedMoviePosterURL!),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: deviceHeight,
        width: deviceWidth,
        color: Colors.black,
      );
    }
  }

  Widget _foregroundWidgets(
    double deviceHeight,
    double deviceWidth,
    MainPageDataController mainPageDataController,
    MainPageData mainPageData,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, deviceHeight * 0.02, 0, 0),
      child: SizedBox(
        width: deviceWidth * 0.88,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _topBarWidget(deviceHeight, deviceWidth, mainPageData,
                mainPageDataController),
            Container(
              height: deviceHeight * 0.85,
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
              child: _moviesListViewWidget(deviceHeight, deviceWidth,
                  mainPageData, mainPageDataController),
            )
          ],
        ),
      ),
    );
  }

  Widget _topBarWidget(
    double deviceHeight,
    double deviceWidth,
    MainPageData mainPageData,
    MainPageDataController mainPageDataController,
  ) {
    return Container(
      height: deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchFieldWidget(deviceHeight, deviceWidth, mainPageDataController),
          _categorySelectionWidget(mainPageDataController,
              mainPageData.searchCategory ?? SearchCategory.popular),
        ],
      ),
    );
  }

  Widget _searchFieldWidget(
    double deviceHeight,
    double deviceWidth,
    MainPageDataController mainPageDataController,
  ) {
    return SizedBox(
      width: deviceWidth * 0.50,
      height: deviceHeight * 0.05,
      child: TextField(
        controller: _searchTextFieldController,
        onChanged: (input) {
          mainPageDataController.updateSearchText(input);
        },
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: _border(),
          border: _border(),
          prefixIcon: const Icon(Icons.search, color: Colors.white24),
          hintStyle: const TextStyle(color: Colors.white54),
          hintText: 'Search....',
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white24),
    );
  }

  Widget _categorySelectionWidget(
    MainPageDataController mainPageDataController,
    String selectedCategory,
  ) {
    return DropdownButton<String>(
      dropdownColor: Colors.black38,
      value: selectedCategory,
      icon: const Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (String? value) {
        if (value != null) {
          _searchTextFieldController.clear(); // Clear the search field
          mainPageDataController.updateSearchCategory(value);
        }
      },
      items: const [
        DropdownMenuItem(
          value: SearchCategory.popular,
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.upcoming,
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.latest,
          child: Text(
            SearchCategory.latest,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.nowPlaying,
          child: Text(
            SearchCategory.nowPlaying,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.topRated,
          child: Text(
            SearchCategory.topRated,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.none,
          child: Text(
            SearchCategory.none,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _moviesListViewWidget(
    double deviceHeight,
    double deviceWidth,
    MainPageData mainPageData,
    MainPageDataController mainPageDataController,
  ) {
    final List<Movie> movies = mainPageData.movies ?? [];

    if (movies.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            final before = scrollNotification.metrics.extentBefore;
            final max = scrollNotification.metrics.maxScrollExtent;
            if (before == max) {
              // Call the fetch movies method from the controller
              mainPageDataController.fetchMovies();
              return true;
            }
          }
          return false;
        },
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int count) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: deviceHeight * 0.01, horizontal: 0),
              child: GestureDetector(
                onTap: () {
                  ref.read(selectedMoviePosterURLProvider.notifier).state =
                      movies[count].posterURL;
                  // Navigate to the movie details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(
                          movie: movies[count]), // Updated to MovieDetailsPage
                    ),
                  );
                },
                child: MovieTile(
                  movie: movies[count],
                  height: deviceHeight * 0.20,
                  width: deviceWidth * 0.85,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
