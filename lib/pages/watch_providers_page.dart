import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/movie_service.dart';
import '../model/app_provider.dart' as app_provider;
import '../model/movie.dart';
import 'embed_page.dart'; // Import the WebView page

final movieServiceProvider = Provider((ref) => MovieService());

class WatchProvidersPage extends ConsumerWidget {
  final Movie movie;

  const WatchProvidersPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieService = ref.watch(movieServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Watch ${movie.name}'),
      ),
      body: FutureBuilder<List<app_provider.Provider>>(
        future: movieService
            .getWatchProviders(movie.id!), // Ensure movie.id is not null
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No providers available.'));
          }

          final providers = snapshot.data!;
          return ListView.builder(
            itemCount: providers.length,
            itemBuilder: (context, index) {
              final provider = providers[index];
              return ListTile(
                leading: provider.logoPath != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${provider.logoPath}')
                    : const Icon(Icons.image_not_supported),
                title: Text(provider.name ?? 'Unknown'),
                onTap: () async {
                  // Get the embed URL for the movie using the TMDB ID
                  final embedUrl = await movieService.getMovieEmbedUrl(
                      tmdbId: movie.id.toString());

                  // Navigate to the WebView to play the video
                  if (context.mounted) {
                    // Check if context is still mounted
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmbedPage(
                            embedUrl: embedUrl, title: movie.name ?? 'Movie'),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
