import 'package:flutter/material.dart';
import '../model/tv_show.dart';
import 'embed_page.dart';

class TVShowDetailsPage extends StatefulWidget {
  final TVShow tvShow;

  const TVShowDetailsPage({super.key, required this.tvShow});

  @override
  TVShowDetailsPageState createState() => TVShowDetailsPageState();
}

class TVShowDetailsPageState extends State<TVShowDetailsPage> {
  int selectedSeason = 1;
  int selectedEpisode = 1;

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tvShow.name ?? 'TV Show Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmbedPage(
                      embedUrl: _constructEmbedUrl(
                        tmdbId: widget.tvShow.id,
                        season: selectedSeason,
                        episode: selectedEpisode,
                      ),
                      title: widget.tvShow.name ?? 'TV Show',
                    ),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center, // Center the text
                children: [
                  Image.network(
                    widget.tvShow.posterURL,
                    height: deviceHeight * 0.72,
                    width: deviceWidth,
                    fit: BoxFit.cover,
                  ),
                  // Overlay the text on top of the image
                  Container(
                    height: deviceHeight * 0.72,
                    width: deviceWidth,
                    alignment: Alignment.center,
                    color: Colors.black45
                        .withOpacity(0.5), // Semi-transparent background
                    child: const Text(
                      'Click here to play',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.tvShow.overview ?? 'No description available',
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.justify,
              ),
            ),
            _buildSeasonAndEpisodeSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonAndEpisodeSelector() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Season:', style: TextStyle(fontSize: 16)),
          DropdownButton<int>(
            value: selectedSeason,
            items: List.generate(10, (index) => index + 1).map((season) {
              return DropdownMenuItem<int>(
                value: season,
                child: Text('Season $season'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedSeason = value!;
              });
            },
          ),
          const SizedBox(height: 10),
          const Text('Select Episode:', style: TextStyle(fontSize: 16)),
          DropdownButton<int>(
            value: selectedEpisode,
            items: List.generate(20, (index) => index + 1).map((episode) {
              return DropdownMenuItem<int>(
                value: episode,
                child: Text('Episode $episode'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedEpisode = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  String _constructEmbedUrl({
    required int? tmdbId,
    required int season,
    required int episode,
  }) {
    return 'https://vidsrc.xyz/embed/tv/$tmdbId/$season-$episode';
  }
}
