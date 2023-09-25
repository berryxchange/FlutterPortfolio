//Our CRUD layer
abstract class Repository {
  Model create();
  Model get(int id);
  List<Model> getAll();
  void update({required Model item});
  void delete({required Model item});
  void clear();
}

//The Data model
class Model {
  final int id;
  final Map data;

  const Model({required this.id, this.data = const {}});
}
