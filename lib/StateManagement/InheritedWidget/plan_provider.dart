import 'package:flutter/material.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/plan.dart';

class PlanProvider extends InheritedWidget {
  //final _plan = Plan();
  final List<Plan> _plans = [];

  PlanProvider({required Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static List<Plan> of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!._plans;
  }
}
