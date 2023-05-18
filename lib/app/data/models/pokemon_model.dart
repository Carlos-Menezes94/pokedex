class PokemonModel {
  int count;
  String? next;
  String? previous;
  List<PokemonResult> results;

  PokemonModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List<PokemonResult>.from(
        json['results'].map((result) => PokemonResult.fromJson(result)),
      ),
    );
  }
}

class PokemonResult {
  String name;
  String url;

  PokemonResult({
    required this.name,
    required this.url,
  });

  factory PokemonResult.fromJson(Map<String, dynamic> json) {
    return PokemonResult(
      name: json['name'],
      url: json['url'],
    );
  }
}
