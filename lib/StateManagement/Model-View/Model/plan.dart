import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/task.dart';
import 'package:flutter_portfolio_project/StateManagement/n-Tier-Architecture/Repositories/repository.dart';

class Plan {
  final int id;
  String name;
  List<Task> tasks = [];

  int get completeCount {
    return tasks.where((task) {
      return task.complete;
    }).length;
  }

  String get completenessMessage {
    return "$completeCount out of ${tasks.length} tasks";
  }

  Plan({required this.id, this.name = ""});

  //Deserialization
  Plan.fromModel({required Model model})
      : id = model.id,
        name = (model.data["name"] == null) ? "" : model.data["name"],
        tasks = model.data["tasks"]?.map<Task>((task) {
              return Task.fromModel(model: task);
            })?.toList() ??
            <Task>[];

  Model toModel() {
    return Model(id: id, data: {
      "name": name,
      "tasks": tasks.map((task) {
        return task.toModel();
      }).toList()
    });
  }
}
