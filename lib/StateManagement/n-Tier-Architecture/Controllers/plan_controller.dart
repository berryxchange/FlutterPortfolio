import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/plan.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/task.dart';
import 'package:flutter_portfolio_project/StateManagement/n-Tier-Architecture/Services/plan_services.dart';

class PlanController {
  //final List<Plan> _plans = [];
  final services = PlanServices(); //the storage for plans

  //This public getter cannnot be modified by any other object
  List<Plan> get plans {
    return List.unmodifiable(services.getAllPlans());
  }

  void addNewPlan({required String name}) {
    if (name.isEmpty) {
      return;
    }

    name = _checkForDuplicates(
        items: plans.map((plan) {
          return plan.name;
        }),
        text: name);

    services.createPlan(name: name);
  }

  void savePlan({required Plan plan}) {
    services.savePlan(plan: plan);
  }

  void deletePlan({required Plan plan}) {
    services.delete(plan: plan);
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

    services.addTask(plan: plan, description: description);
  }

  void deleteTask({required Plan plan, required Task task}) {
    services.deleteTask(plan: plan, task: task);
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
