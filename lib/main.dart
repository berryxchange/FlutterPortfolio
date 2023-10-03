import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_portfolio_project/DataPersistenceAndCommunicatingWithTheInternet/ConvertDartModelsIntoJSON/Pizza.dart';
import 'package:flutter_portfolio_project/StateManagement/InheritedWidget/plan_provider.dart';

void main() {
  runApp(PlanProvider(key: null, child: const MasterPlanApp()));
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
      home: const MyHomePage(),
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
    for (var pizza in myMap) {
      Pizza myPizza = Pizza.fromJson(pizza);
      myPizzas.add(myPizza);
    }

    String json = convertToJSON(myPizzas);
    print(json);
    return myPizzas;
  }

  String convertToJSON(List<Pizza> pizzas) {
    String json = "[";
    for (var pizza in pizzas) {
      json += jsonEncode(pizza);
    }
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
        title: const Text("JSON"),
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
                    subtitle: Text("${pizzaSnapshot.data![index].description} - \$ ${pizzaSnapshot.data![index].price}"),
                  );
                });
          },
          future: readJsonFile(),
        ),
      ),
    );
  }
}
