import 'package:flutter/material.dart';

class PokemonModel {
  final String name;
  final String imageUrl;
  final String ability;
  final String type;
  final Color? colorCard;

  static final  Map<String, Color>  colorsTypePokemon = {
    "electric": Colors.yellow,
    "fire": Colors.red,
    "grass": Colors.green,
    "normal": Colors.blueAccent
  };

  PokemonModel({
    required this.name,
    required this.imageUrl,
    required this.ability,
    required this.type,
    required this.colorCard,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    String pokemonType = json['types'][0]['type']['name'];

    return PokemonModel(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      ability: json['abilities'][0]['ability']['name'],
      type: pokemonType, 
      colorCard: colorsTypePokemon[pokemonType] ?? Colors.white,
    );
  }
}
