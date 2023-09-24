import 'package:flutter/material.dart';
import 'package:flutter_portfolio_project/StateManagement/InheritedWidget/plan_provider.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/plan.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/View/plan_screen.dart';

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({super.key});

  @override
  State<PlanCreatorScreen> createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Master Plans")),
      body: Column(children: <Widget>[
        _buildListCreator(),
        Expanded(
          child: _buildMasterPlans(),
        )
      ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  Widget _buildListCreator() {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Material(
          color: Theme.of(context).cardColor,
          elevation: 10,
          child: TextField(
              controller: textController,
              decoration: InputDecoration(
                  labelText: "Add a plan", contentPadding: EdgeInsets.all(20)),
              onEditingComplete: addPlan),
        ));
  }

  void addPlan() {
    final text = textController.text;
    if (text.isEmpty) {
      return;
    }

    final plan = Plan();
    plan.name = text;
    PlanProvider.of(context).add(plan);
    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  Widget _buildMasterPlans() {
    final plans = PlanProvider.of(context);

    if (plans.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.note,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            "You do not have any plans yet.",
            style: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      );
    }
    return ListView.builder(
        itemCount: plans.length,
        itemBuilder: (BuildContext context, int index) {
          final plan = plans[index];
          return ListTile(
            title: Text(plan.name),
            subtitle: Text(plan.completenessMessage),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return PlanScreen(key: null, plan: plan);
              }));
            },
          );
        });
  }
}
