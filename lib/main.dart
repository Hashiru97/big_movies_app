// lib/main.dart
import 'dart:io'; // Import for HttpOverrides
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './pages/splash_page.dart';
import './pages/main_page.dart';

// Add SSL certificate bypass (for development use only)
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides(); // Apply the SSL bypass globally

  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: _launchApp,
    ),
  );
}

void _launchApp() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'big movies',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const MainPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
