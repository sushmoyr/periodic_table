class Settings {
  final String name;
  final String lang;
  final bool isNameSet;

  Settings({
    required this.name,
    required this.lang,
    required this.isNameSet,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      name: json['name'],
      lang: json['lang'],
      isNameSet: json['isNameSet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lang': lang,
      'isNameSet': isNameSet,
    };
  }
}
