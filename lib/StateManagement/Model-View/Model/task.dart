import 'package:flutter_portfolio_project/StateManagement/n-Tier-Architecture/Repositories/repository.dart';

class Task {
  final int id;
  String description;
  bool complete;

  Task({required this.id, this.description = "", this.complete = false});

  //Serialization
  Task.fromModel({required Model model})
      : id = model.id,
        description = model.data["description"],
        complete = model.data["complete"];

  Model toModel() {
    return Model(
        id: id, data: {"description": description, "complete": complete});
  }
}
