import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_fteam/features/todo/presentation/providers/pokemon_provider.dart';
import 'package:todo_fteam/features/todo/presentation/widgets/confirmation_dialog.dart';

class TodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PoKteam',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF042449),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Color(0xFF042449),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Monte sua lista de favoritos!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Digite o nome do seu pokémon ...',
                    hintStyle: TextStyle(color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final name = _controller.text.trim().toLowerCase();

                      if (name.isNotEmpty) {
                        context.read<PokemonProvider>().addPokemonToList(
                          name,
                          context,
                        );
                        _controller.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF042449),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('ADICIONAR'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<PokemonProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: Color(0xFF042449)),
                  );
                }
                if (provider.todoList.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhum Pokémon adicionado.',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: provider.todoList.length,
                  itemBuilder: (context, index) {
                    final pokemon = provider.todoList[index];
                    return Card(
                      elevation: 4,
                      color: pokemon.colorCard,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            pokemon.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          pokemon.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Habilidade: ${pokemon.ability}',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              'Tipo: ${pokemon.type} ',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmationDialog(
                                title: 'Excluir favorito',
                                content:
                                    'Você tem certeza que deseja excluir "${pokemon.name}"?',
                                onCancel: () {
                                  Navigator.of(context).pop();
                                },
                                onConfirm: () {
                                  context
                                      .read<PokemonProvider>()
                                      .deletarFavorito(pokemon);
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
