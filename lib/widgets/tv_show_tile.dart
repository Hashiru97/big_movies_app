import 'package:flutter/material.dart';
import '../model/tv_show.dart';

class TVShowTile extends StatelessWidget {
  final TVShow tvShow;
  final double height;
  final double width;

  const TVShowTile({
    required this.tvShow,
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
          _tvShowPosterWidget(tvShow.posterURL),
          _tvShowInfoWidget(),
        ],
      ),
    );
  }

  Widget _tvShowInfoWidget() {
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
                  tvShow.name!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                tvShow.voteAverage != null
                    ? tvShow.voteAverage!.toStringAsFixed(1)
                    : 'N/A', // Provide a fallback if the value is null
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${tvShow.language?.toUpperCase()} | ${tvShow.firstAirDate}', // Updated field
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            tvShow.overview ?? 'No description available',
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _tvShowPosterWidget(String imageUrl) {
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
