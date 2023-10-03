import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_portfolio_project/DataPersistenceAndCommunicatingWithTheInternet/ConvertDartModelsIntoJSON/Pizza.dart';
import 'package:flutter_portfolio_project/StateManagement/InheritedWidget/plan_provider.dart';
import 'package:flutter_portfolio_project/StateManagement/Model-View/View/plan_screen.dart';
import 'package:flutter_portfolio_project/StateManagement/Multi-Screen/Views/plan_creator_screen.dart';

void main() {
  runApp(PlanProvider(key: null, child: MasterPlanApp()));
}

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter JSON Demo",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pizzaString = "";
  Future<List<Pizza>> readJsonFile() async {
    String myString = await DefaultAssetBundle.of(context)
        .loadString("assets/pizzalist.json");

    //decode the JSON file
    List myMap = jsonDecode(myString);

    //list of pizza
    List<Pizza> myPizzas = [];
    myMap.forEach((pizza) {
      Pizza myPizza = Pizza.fromJson(pizza);
      myPizzas.add(myPizza);
    });

    String json = convertToJSON(myPizzas);
    print(json);
    return myPizzas;
  }

  String convertToJSON(List<Pizza> pizzas) {
    String json = "[";
    pizzas.forEach((pizza) {
      json += jsonEncode(pizza);
    });
    json += "]";
    return json;
  }

  @override
  void initState() {
    readJsonFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON"),
      ),
      body: Container(
        child: FutureBuilder(
          builder:
              (BuildContext context, AsyncSnapshot<List<Pizza>> pizzaSnapshot) {
            return ListView.builder(
                itemCount: (pizzaSnapshot.data == null)
                    ? 0
                    : pizzaSnapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(pizzaSnapshot.data![index].pizzaName),
                    subtitle: Text(pizzaSnapshot.data![index].description +
                        " - \$ " +
                        pizzaSnapshot.data![index].price.toString()),
                  );
                });
          },
          future: readJsonFile(),
        ),
      ),
    );
  }
}
