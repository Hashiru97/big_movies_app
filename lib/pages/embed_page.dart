import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmbedPage extends StatelessWidget {
  final String embedUrl;
  final String title;

  const EmbedPage({super.key, required this.embedUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watch $title'),
      ),
      body: WebView(
        initialUrl: embedUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
