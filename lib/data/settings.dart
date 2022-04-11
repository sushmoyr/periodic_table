class Settings {
  final String name;
  final String lang;

  Settings({
    required this.name,
    required this.lang,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      name: json['name'],
      lang: json['lang'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lang': lang,
    };
  }

  Settings copyWith({String? name, String? lang}) => Settings(
        name: name ?? this.name,
        lang: lang ?? this.lang,
      );
}
