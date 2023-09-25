import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/plan.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/task.dart';
import 'package:flutter_portfolio_project/StateManagement/n-Tier-Architecture/Repositories/in_memory_cache.dart';
import 'package:flutter_portfolio_project/StateManagement/n-Tier-Architecture/Repositories/repository.dart';

class PlanServices {
  final Repository _repository = InMemoryCache();

  Plan createPlan({required String name}) {
    //creates an item
    final model = _repository.create(); //empty model in memory
    final plan = Plan.fromModel(model: model); //empty plan or with default data

    //set name to plan
    plan.name = name;

    //update plan
    savePlan(plan: plan);
    return plan;
  }

  void savePlan({required Plan plan}) {
    //updates the already created item in the temp list
    _repository.update(item: plan.toModel());
  }

  void delete({required Plan plan}) {
    _repository.delete(item: plan.toModel());
  }

  List<Plan> getAllPlans() {
    //map all plans to a list from temp list
    return _repository.getAll().map<Plan>((model) {
      return Plan.fromModel(model: model);
    }).toList();
  }

  void addTask({required Plan plan, required String description}) {
    //set the id for the task
    final id = (plan.tasks.isEmpty) ? 1 : plan.tasks.last.id;

    //create the task
    final task = Task(id: id, description: description);

    //set task to plan
    plan.tasks.add(task);

    //update plan
    savePlan(plan: plan);
  }

  void deleteTask({required Plan plan, required Task task}) {
    //remove task
    plan.tasks.remove(task);

    //update plan
    savePlan(plan: plan);
  }
}
