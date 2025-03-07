 
import 'package:todo_fteam/features/todo/data/repositories/pokemon_repository.dart';
import 'package:todo_fteam/features/todo/domain/entities/pokemon.dart';

class GetPokemon {
  final PokemonRepository repository;

  GetPokemon(this.repository);

  Future<Pokemon> call(String name) async {
    return await repository.getPokemon(name);
  }
}
