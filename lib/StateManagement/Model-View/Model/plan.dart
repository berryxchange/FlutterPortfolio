import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/task.dart';

class Plan {
  String name;
  final List<Task> tasks = [];

  int get completeCount {
    return tasks.where((task) {
      return task.complete;
    }).length;
  }

  String get completenessMessage {
    return "$completeCount out of ${tasks.length} tasks";
  }

  Plan({this.name = ""});
}
