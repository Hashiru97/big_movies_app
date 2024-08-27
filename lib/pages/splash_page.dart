import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../services/http_service.dart';
import '../services/movie_service.dart';
import '../model/config.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({
    super.key, // Use super parameter for key
    required this.onInitializationComplete,
  });

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((_) => _setup(context).then(
          (_) => widget.onInitializationComplete(),
        ));
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;
    final configFile = await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configFile);

    getIt.registerSingleton<AppConfig>(
      AppConfig(
          baseApiUrl: configData['BASE_API_URL'],
          baseImageApiUrl: configData['BASE_IMAGE_API_URL'],
          apiKey: configData['API_KEY']),
    );

    getIt.registerSingleton<HttpService>(
      HttpService(),
    );

    getIt.registerSingleton<MovieService>(
      MovieService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Removed const because MaterialApp is not const
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
