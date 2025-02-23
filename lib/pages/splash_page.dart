import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart'; // Use Logger instead of print
import '../services/http_service.dart';
import '../services/movie_service.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({
    super.key,
    required this.onInitializationComplete,
  });

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  final Logger _logger = Logger(); // Initialize Logger

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((_) => _setup(context).then(
          (_) => widget.onInitializationComplete(),
        ));
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;

    try {
      final configFile = await rootBundle.loadString('assets/config/main.json');
      final configData = jsonDecode(configFile);

      final baseApiUrl = configData['BASE_API_URL'] as String?;
      final baseImageApiUrl = configData['BASE_IMAGE_API_URL'] as String?;
      final apiKey = configData['API_KEY'] as String?;

      if (baseApiUrl == null || baseImageApiUrl == null || apiKey == null) {
        throw Exception('Invalid configuration data.');
      }

      getIt.registerSingleton<HttpService>(HttpService());
      getIt.registerSingleton<MovieService>(MovieService());
    } catch (e) {
      _logger.e('Initialization failed', e); // Use logger instead of print
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'big',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
