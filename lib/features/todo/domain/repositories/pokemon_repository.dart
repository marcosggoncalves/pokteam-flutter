import 'package:todo_fteam/features/todo/domain/entities/pokemon.dart';

abstract class PokemonRepositoryInterface {
  Future<Pokemon> getPokemon(String name);
}
