import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/plan.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/task.dart';

class PlanController {
  final List<Plan> _plans = [];

  //This public getter cannnot be modified by any other object
  List<Plan> get plans {
    return List.unmodifiable(_plans);
  }

  void addNewPlan({required String name}) {
    if (name.isEmpty) {
      return;
    }

    name = _checkForDuplicates(
        items: _plans.map((plan) {
          return plan.name;
        }),
        text: name);

    final plan = Plan();
    plan.name = name;
    _plans.add(plan);
  }

  void deletePlan({required Plan plan}) {
    _plans.remove(plan);
  }



  createNewTask({required Plan plan, required String description}) {
    //check if description is empty
    if (description == "" || description.isEmpty) {
      description = "New task";
    }

    //get task list descriptions
    Iterable<String> taskListDescripions = plan.tasks.map((task) {
      return task.description;
    });

    //check for duplicate descriptions in the task list
    description =
        _checkForDuplicates(items: taskListDescripions, text: description);

    final task = Task();
    task.description = description;
    plan.tasks.add(task);
  }

  void deleteTask({required Plan plan, required Task task}) {
    plan.tasks.remove(task);
  }

  String _checkForDuplicates(
      {required Iterable<String> items, required String text}) {
    final duplicatedCount = items.where((item) {
      return item.contains(text);
    }).length;

    if (duplicatedCount > 0) {
      text += " ${duplicatedCount + 1}";
    }

    return text;
  }
}
