import 'package:flutter/material.dart';
import 'package:flutter_portfolio_project/StateManagement/InheritedWidget/plan_provider.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/plan.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/task.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({required Key? key, required this.plan}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  //final plan = Plan();
  Plan get plan {
    return widget.plan;
  }

  late ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    scrollController = ScrollController();

    scrollController.addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final plan = PlanProvider.of(context);
    return WillPopScope(
      onWillPop: () {
        final controller = PlanProvider.of(context);
        controller.savePlan(plan: plan);
        Plan thisPlan = controller.plans.firstWhere((cachedPlan) {
          return cachedPlan.id == plan.id;
        });
        
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Master Plan"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildList(plan: plan)),
            SafeArea(child: Text(plan.completenessMessage))
          ],
        ),
        floatingActionButton: _buildAddTaskButton(plan: plan),
      ),
    );
  }

  Widget _buildAddTaskButton({required Plan plan}) {
    return FloatingActionButton(
      onPressed: () {
        final controller = PlanProvider.of(context);
        controller.createNewTask(plan: plan, description: "");
        setState(() {});
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _buildList({required Plan plan}) {
    return ListView.builder(
        controller: scrollController,
        itemCount: plan.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildTaskTile(task: plan.tasks[index]);
        });
  }

  Widget _buildTaskTile({required Task task}) {
    return Dismissible(
        key: ValueKey(task),
        background: Container(color: Colors.red),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          final controller = PlanProvider.of(context);
          controller.deleteTask(plan: plan, task: task);
          setState(() {});
        },
        child: ListTile(
          leading: Checkbox(
              value: task.complete,
              onChanged: (selected) {
                return setState(() {
                  task.complete = selected!;
                });
              }),
          title: TextFormField(
            initialValue: task.description,
            onFieldSubmitted: (text) {
              setState(() {
                task.description = text;
              });
            },
            onChanged: (text) {
              setState(() {
                task.description = text;
              });
            },
          ),
        ));
  }
}
