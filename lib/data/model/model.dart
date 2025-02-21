class Livro {
  String? id; // ID do documento no Firestore
  String titulo;
  String autor;
  int anoPublicacao;
  String genero;
  String sinopse;
  double avaliacao; // Avaliação de 1 a 5
  String usuarioId; // ID do usuário que adicionou o livro
  DateTime dataCadastro;

  Livro({
    this.id,
    required this.titulo,
    required this.autor,
    required this.anoPublicacao,
    required this.genero,
    required this.sinopse,
    required this.avaliacao,
    required this.usuarioId,
    required this.dataCadastro,
  });

  // Converte um Livro para um Map (útil para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'autor': autor,
      'anoPublicacao': anoPublicacao,
      'genero': genero,
      'sinopse': sinopse,
      'avaliacao': avaliacao,
      'usuarioId': usuarioId,
      'dataCadastro': dataCadastro,
    };
  }
}
