import 'package:flutter/material.dart';
import 'package:todo_fteam/features/todo/domain/entities/pokemon.dart';
import 'package:todo_fteam/features/todo/domain/usecases/get_pokemon.dart';
import 'package:todo_fteam/features/todo/presentation/widgets/alert_widget.dart';

class PokemonProvider with ChangeNotifier {
  final GetPokemon getPokemon;
  List<Pokemon> todoList = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  PokemonProvider({required this.getPokemon});

  Future<void> addPokemonToList(String name, BuildContext context) async {
    _setLoading(true);

    if (todoList.any(
      (pokemon) => pokemon.name.toLowerCase() == name.toLowerCase(),
    )) {
      _setLoading(false);
      AlertWidget.show(context, "Pokémon já está na sua lista!");
      return;
    }

    try {
      todoList.add(await getPokemon(name));
      notifyListeners();
    } catch (e) {
      // ignore: use_build_context_synchronously
      AlertWidget.show(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void deletarFavorito(Pokemon pokemon) {
    todoList.remove(pokemon);
    notifyListeners();
  }
}
