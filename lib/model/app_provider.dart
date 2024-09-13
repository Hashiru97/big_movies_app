class Provider {
  final String? name;
  final String? logoPath;
  final String? link;

  Provider({this.name, this.logoPath, this.link});

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      name: json['provider_name'],
      logoPath: json['logo_path'],
      link: json[
          'link'], // This may need adjustment based on the data you receive
    );
  }
}
