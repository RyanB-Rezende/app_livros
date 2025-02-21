import 'package:app_livros/data/model/model.dart';
import 'package:app_livros/data/repositories/repository.dart';
import 'package:app_livros/presentation/viewmodel/viewmodel.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>(); // Chave para o formulário
  final LivroViewmodel _viewmodel =
      LivroViewmodel(LivroRepository()); // Instância do ViewModel

  // Controladores para os campos do formulário
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _anoPublicacaoController =
      TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _sinopseController = TextEditingController();
  final TextEditingController _avaliacaoController = TextEditingController();

  @override
  void dispose() {
    // Libera os controladores quando o widget for destruído
    _tituloController.dispose();
    _autorController.dispose();
    _anoPublicacaoController.dispose();
    _generoController.dispose();
    _sinopseController.dispose();
    _avaliacaoController.dispose();
    super.dispose();
  }

  // Método para cadastrar um novo livro
  Future<void> _cadastrarLivro() async {
    if (_formKey.currentState!.validate()) {
      // Cria um novo objeto Livro com os dados do formulário
      final novoLivro = Livro(
        titulo: _tituloController.text,
        autor: _autorController.text,
        anoPublicacao: int.parse(_anoPublicacaoController.text),
        genero: _generoController.text,
        sinopse: _sinopseController.text,
        avaliacao: double.parse(_avaliacaoController.text),
        usuarioId: 'usuarioId', // Substitua pelo ID do usuário logado
        dataCadastro: DateTime.now(), // Data atual
      );

      // Adiciona o livro ao Firestore
      await _viewmodel.addLivro(novoLivro);

      // Navega de volta para a tela anterior
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Livro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _cadastrarLivro, // Salva o novo livro
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título do livro.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _autorController,
                decoration: const InputDecoration(labelText: 'Autor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o autor do livro.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _anoPublicacaoController,
                decoration:
                    const InputDecoration(labelText: 'Ano de Publicação'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o ano de publicação.';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um ano válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _generoController,
                decoration: const InputDecoration(labelText: 'Gênero'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o gênero do livro.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sinopseController,
                decoration: const InputDecoration(labelText: 'Sinopse'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a sinopse do livro.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _avaliacaoController,
                decoration:
                    const InputDecoration(labelText: 'Avaliação (1 a 5)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a avaliação do livro.';
                  }
                  final avaliacao = double.tryParse(value);
                  if (avaliacao == null || avaliacao < 1 || avaliacao > 5) {
                    return 'Por favor, insira uma avaliação válida (1 a 5).';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
