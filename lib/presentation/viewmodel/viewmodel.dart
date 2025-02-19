import 'package:app_livros/data/repositories/repository.dart';
import '../../data/model/model.dart';

class LivroViewmodel {
  final LivroRepository repository;

  LivroViewmodel(this.repository);

  Future<void> addLivro(Livro livro) async {
    await repository.insertLivro(livro);
  }

  Future<List<Livro>> getLivros() async {
    return await repository.getLivro();
  }

  Future<void> updateLivro(String id, Livro livro) async {
    await repository.updateLivro(id, livro);
  }

  Future<void> deleteLivro(String id) async {
    await repository.deleteLivro(id);
  }
}
