import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_fteam/core/network/api_service.dart';
import 'package:todo_fteam/features/todo/data/datasources/pokemon_api.dart';
import 'package:todo_fteam/features/todo/data/repositories/pokemon_repository.dart';
import 'package:todo_fteam/features/todo/domain/usecases/get_pokemon.dart';
import 'package:todo_fteam/features/todo/presentation/providers/pokemon_provider.dart';
import 'package:todo_fteam/features/todo/presentation/screens/todo_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load();  
  
  runApp(AppFteam());
}
class AppFteam extends StatelessWidget {
  const AppFteam({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
        ProxyProvider<ApiService, PokemonApiDataSource>(
          update: (_, apiService, __) => PokemonApiDataSource(apiService: apiService),
        ),
        ProxyProvider<PokemonApiDataSource, PokemonRepository>(
          update: (_, dataSource, __) => PokemonRepository(dataSource),
        ),
        ProxyProvider<PokemonRepository, GetPokemon>(
          update: (_, repository, __) => GetPokemon(repository),
        ),
        ChangeNotifierProvider(
          create: (context) => PokemonProvider(
            getPokemon: context.read<GetPokemon>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'App Fteam',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TodoScreen(),
      ),
    );
  }
}