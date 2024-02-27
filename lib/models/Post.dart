class Country {
  Map<String, dynamic> flags;
  Map<String, dynamic> name;
  int population;
  String region;
  List<String> capital;
  List<String> continents;

  Country(this.flags, this.name, this.population, this.region, this.capital, this.continents);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      Map<String, dynamic>.from(json["flags"]),
      Map<String, dynamic>.from(json["name"]),
      json["population"],
      json["region"],
      List<String>.from(json["capital"]),
      List<String>.from(json["continents"]),
    );
  }
}

