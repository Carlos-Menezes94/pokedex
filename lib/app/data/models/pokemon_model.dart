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
  List<Map<String, dynamic>> baseStats;
  int height;
  int weight;

  PokemonResult({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.baseStats,
    required this.height,
    required this.weight,
  });

  factory PokemonResult.fromJson(Map<String, dynamic> json) {
    final pokemonStats = (json['stats'] as List<dynamic>).map((stat) {
      final statName = stat['stat']['name'];
      final statValue = stat['base_stat'];
      return {
        'name': statName,
        'value': statValue,
      };
    }).toList();

    return PokemonResult(
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      types: (json['types'] as List<dynamic>)
          .map((type) => type['type']['name'] as String)
          .toList(),
      baseStats: pokemonStats,
      height: json['height'],
      weight: json['weight'],
    );
  }
}
