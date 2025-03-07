 
import 'package:flutter/material.dart';
import 'package:todo_fteam/features/todo/data/datasources/pokemon_api.dart';
import 'package:todo_fteam/features/todo/domain/entities/pokemon.dart';
import 'package:todo_fteam/features/todo/domain/repositories/pokemon_repository.dart';

class PokemonRepository implements PokemonRepositoryInterface {
  final PokemonApiDataSource dataSource;

  PokemonRepository(this.dataSource);

  @override
  Future<Pokemon> getPokemon(String name) async {
    final model = await dataSource.fetchPokemon(name);
    return Pokemon(
      name: model.name,
      imageUrl: model.imageUrl,
      ability: model.ability,
      type: model.type,
      colorCard: model.colorCard ?? Colors.white,
    );
  }
}
