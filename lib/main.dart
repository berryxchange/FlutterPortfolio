import 'package:flutter/material.dart';
import 'package:flutter_portfolio_project/StateManagement/InheritedWidget/plan_provider.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/View/plan_screen.dart';
import 'package:flutter_portfolio_project/StateManagement/Multi-Screen/Views/plan_creator_screen.dart';

void main() {
  runApp(PlanProvider(
        key: null,
        child: MasterPlanApp()));
}

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      home: PlanCreatorScreen(),
    );
  }
}
