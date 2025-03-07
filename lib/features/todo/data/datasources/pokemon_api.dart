 
import 'package:todo_fteam/core/network/api_service.dart';
import 'package:todo_fteam/features/todo/data/models/pokemon_model.dart';

class PokemonApiDataSource {
  final ApiService apiService;

  PokemonApiDataSource({required this.apiService});

  Future<PokemonModel> fetchPokemon(String name) async {
    final data = await apiService.get(name);
    return PokemonModel.fromJson(data);
  }
}
