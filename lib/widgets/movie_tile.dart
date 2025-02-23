import 'package:flutter/material.dart';
import '../model/movie.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final double height;
  final double width;

  const MovieTile({
    required this.movie,
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _moviePosterWidget(movie.posterURL),
          _movieInfoWidget(),
        ],
      ),
    );
  }

  Widget _movieInfoWidget() {
    return SizedBox(
      height: height,
      width: width * 0.65,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.45,
                child: Text(
                  movie.name!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                movie.rating!.toStringAsFixed(
                    1), // Display rating with one decimal place
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            '${movie.language!.toUpperCase()} | R: ${movie.isAdult} | ${movie.releaseDate}',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            movie.description!,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 8),
          ),
        ],
      ),
    );
  }

  Widget _moviePosterWidget(String imageUrl) {
    return Container(
      height: height,
      width: width * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
