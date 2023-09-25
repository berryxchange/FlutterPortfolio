import 'package:flutter_portfolio_project/StateManagement/Repositories/repository.dart';

class InMemoryCache implements Repository {
  //Mapped storage for data
  final _storage = Map<int, Model>();

  @override
  Model create() {
    //set ids from list of _storage keys and sort them
    final ids = _storage.keys.toList();
    ids.sort();

    //set the ID of the model
    final id = (ids.length == 0) ? 1 : ids.last + 1;
    final model = Model(id: id);

    //set in storage the model according to the ID
    _storage[id] = model;

    //return the model
    return model;
  }

  @override
  Model get(int id) {
    return _storage[id]!;
  }

  @override
  List<Model> getAll() {
    return _storage.values.toList(growable: false);
  }

  @override
  void update({required Model item}) {
    _storage[item.id] = item;
  }

  @override
  void delete({required Model item}) {
    _storage.remove(item.id);
  }

  @override
  void clear() {
    _storage.clear();
  }
}
