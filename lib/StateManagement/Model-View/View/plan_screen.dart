import 'package:flutter/material.dart';
import 'package:flutter_portfolio_project/StateManagement/InheritedWidget/plan_provider.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/plan.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/task.dart';

class PlanScreen extends StatefulWidget {
  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  //final plan = Plan();
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
    final plan = PlanProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Master Plan"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildList(plan: plan)),
          SafeArea(child: Text(plan.completenessMessage))
        ],
      ),
      floatingActionButton: _buildAddTaskButton(plan: plan),
    );
  }

  Widget _buildAddTaskButton({required Plan plan}) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          plan.tasks.add(Task());
        });
      },
      child: Icon(Icons.add),
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
    return ListTile(
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
    );
  }
}
