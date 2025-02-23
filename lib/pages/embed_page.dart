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
        navigationDelegate: (NavigationRequest request) {
          if (_isAdUrl(request.url)) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  bool _isAdUrl(String url) {
    List<String> adDomains = [
      'ads',
      'popads',
      'doubleclick',
      'adservice',
      'trackers',
      'googleadservices',
      'ad-delivery',
      'openx',
    ];

    return adDomains.any((adDomain) => url.contains(adDomain));
  }
}
