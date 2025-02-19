import '../../core/database.dart';
import '../model/model.dart';

class LivroRepository {
  final String collection = 'Livros';

  Future<void> insertLivro(Livro livro) async {
    await DatabaseHelper.addDocument(collection, livro.toMap());
  }

  Future<List<Livro>> getLivro() async {
    List<Map<String, dynamic>> livroMaps =
        await DatabaseHelper.getDocuments(collection);
    return livroMaps.map((map) {
      return Livro(
        id: map['id'], // O Firestore gera um ID string
        titulo: map['titulo'],
        autor: map['autor'] ?? '',
        anoPublicacao: map['anoPublicacao'] ?? '',
        genero: map['genero'] ?? '',
        sinopse: map['sinopse'] ?? '',
        capaUrl: map['capaUrl'] ?? '',
        avaliacao: map['avaliacao'] ?? '',
        usuarioId: map['usuarioId'] ?? '',
        dataCadastro: map['dataCadastro'] ?? '',
      );
    }).toList();
  }

  Future<void> updateLivro(String id, Livro livro) async {
    await DatabaseHelper.updateDocument(collection, id, livro.toMap());
  }

  Future<void> deleteLivro(String id) async {
    await DatabaseHelper.deleteDocument(collection, id);
  }
}
