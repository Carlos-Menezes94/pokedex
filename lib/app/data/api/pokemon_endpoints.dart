class PokemonEndpoints {
  String getPokemon() => 'https://pokeapi.co/api/v2/pokemon?limit=1281';
  String getPokemonDetail(String name) => 'https://pokeapi.co/api/v2/$name';
}
