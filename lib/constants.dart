class AppData {
  static List<String> nomes = [];
  static User? user;
}

class User {
  final String? id;
  final String? nome;
  final List<String>? tarefas;

  User({this.id, this.nome, this.tarefas});
}
