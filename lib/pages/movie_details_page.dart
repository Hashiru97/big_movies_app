import 'package:flutter/material.dart';
import '../model/movie.dart';
import 'embed_page.dart'; // For WebView

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.name ?? 'Movie Details'),
      ),
      body: SingleChildScrollView(
        // To prevent overflow and allow scrolling
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Makes the image stretch the width
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to the WebView with the embed URL
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmbedPage(
                      embedUrl:
                          'https://vidsrc.xyz/embed/movie?tmdb=${movie.id}',
                      title: movie.name ?? 'Movie',
                    ),
                  ),
                );
              },
              child: Image.network(
                movie.posterURL,
                height: deviceHeight * 0.72, // Adjusting height dynamically
                width: deviceWidth, // Set width to device width
                fit: BoxFit.cover, // Cover the full width of the screen
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie.description ?? 'No description available',
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
