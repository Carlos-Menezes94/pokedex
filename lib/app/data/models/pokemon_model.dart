class PokemonModel {
  List<PokemonResult> results;

  PokemonModel({required this.results});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      results: List<PokemonResult>.from(
        (json['results'] as List<dynamic>)
            .map((result) => PokemonResult.fromJson(result)),
      ),
    );
  }
}
class PokemonResult {
  String name;
  String imageUrl;
  List<String> types;
  dynamic baseStats;

  PokemonResult({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.baseStats,
  });

  factory PokemonResult.fromJson(Map<String, dynamic> json) {
    return PokemonResult(
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      types: (json['types'] as List<dynamic>)
          .map((type) => type['type']['name'] as String)
          .toList(),
      baseStats: json['baseStats'],
    );
  }
}

