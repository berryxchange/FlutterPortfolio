import 'package:flutter/material.dart';
import 'package:flutter_portfolio_project/StateManagement/n-Tier-Architecture/Controllers/plan_controller.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/Model/plan.dart';

class PlanProvider extends InheritedWidget {
  //final _plan = Plan();
  final _controller = PlanController();
  final List<Plan> _plans = [];

  PlanProvider({required Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  //returns the place of the PlanProvider controller
  static PlanController of(BuildContext context) {
    PlanProvider? provider =
        context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!._controller;
  }

  /*static List<Plan> of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!._plans;
  }*/
}
