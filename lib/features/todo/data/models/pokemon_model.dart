class PokemonModel {
  final String name;
  final String imageUrl;
  final String ability;

  PokemonModel({
    required this.name,
    required this.imageUrl,
    required this.ability,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      ability: json['abilities'][0]['ability']['name'],
    );
  }
}
