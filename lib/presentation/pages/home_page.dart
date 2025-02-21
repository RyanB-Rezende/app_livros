import 'package:app_livros/data/model/model.dart';
import 'package:app_livros/data/repositories/repository.dart';
import 'package:app_livros/presentation/viewmodel/viewmodel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LivroViewmodel _viewmodel =
      LivroViewmodel(LivroRepository()); // Instância do ViewModel
  List<Livro> _livros = []; // Lista de livros

  @override
  void initState() {
    super.initState();
    _carregarLivros(); // Carrega os livros ao iniciar a tela
  }

  // Método para carregar os livros do Firestore
  Future<void> _carregarLivros() async {
    final livros = await _viewmodel.getLivros();
    setState(() {
      _livros = livros;
    });
  }

  // Método para navegar para a tela de cadastro de livro
  void _navegarParaCadastro() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const CadastroPage()), // Substitua pela sua tela de cadastro
    ).then(
        (_) => _carregarLivros()); // Recarrega os livros após cadastrar um novo
  }

  // Método para navegar para a tela de edição de livro
  void _navegarParaEdicao(Livro livro) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              EditPage(livro: livro)), // Substitua pela sua tela de edição
    ).then((_) => _carregarLivros()); // Recarrega os livros após editar
  }

  // Método para excluir um livro
  Future<void> _excluirLivro(String id) async {
    await _viewmodel.deleteLivro(id);
    _carregarLivros(); // Recarrega a lista após excluir
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Livros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navegarParaCadastro, // Navega para a tela de cadastro
          ),
        ],
      ),
      body: _livros.isEmpty
          ? const Center(child: Text('Nenhum livro cadastrado.'))
          : ListView.builder(
              itemCount: _livros.length,
              itemBuilder: (context, index) {
                final livro = _livros[index];
                return ListTile(
                  title: Text(livro.titulo),
                  subtitle: Text(
                      'Autor: ${livro.autor} - Ano: ${livro.anoPublicacao}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _navegarParaEdicao(
                            livro), // Navega para a tela de edição
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            _excluirLivro(livro.id!), // Exclui o livro
                      ),
                    ],
                  ),
                  onTap: () {
                    // Aqui você pode adicionar a navegação para uma tela de detalhes do livro
                  },
                );
              },
            ),
    );
  }
}
