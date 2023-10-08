import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_portfolio_project/StateManagement/InheritedWidget/plan_provider.dart';
import 'package:flutter_portfolio_project/AdvancedStateManagement/DartStreams/Stream.dart';

void main() {
  runApp(PlanProvider(key: null, child: const MasterPlanApp()));
}

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stream",
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  late Color bgColor = Colors.white;
  late ColorStream colorStream;

  //stream controller
  late int lastNumber = 0;
  StreamController numberStreamController = StreamController();
  late NumberStream numberStream;

  //Stream Transformer
  late StreamTransformer streamTransformer;

  //Stream Subscription
  late StreamSubscription streamSubscription;

  changeColor() async {
    /*await for (var eventColor in colorStream.getColors()) {
      setState(() {
        bgColor = eventColor;
      });
    }*/

    colorStream.getColors().listen((eventColor) {
      setState(() {
        bgColor = eventColor;
      });
    });
  }

  void stopStream() {
    numberStreamController.close();
  }

  @override
  void initState() {
    //colorStream = ColorStream();
    //changeColor();

    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    Stream stream = numberStreamController.stream;

    /*streamTransformer =
        StreamTransformer<int, dynamic>.fromHandlers(handleData: (value, sink) {
      sink.add(value * 10);
    }, handleError: ((error, stackTrace, sink) {
      sink.add(-1);
    }), handleDone: (sink) {
      sink.close();
    });
*/
    /*stream.listen((eventNumber) {
      setState(() {
        lastNumber = eventNumber;
      });
    }).onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });
    */

    /*stream.transform(streamTransformer).listen((eventNumber) {
      setState(() {
        lastNumber = eventNumber;
      });
    }).onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });
*/

    streamSubscription = stream.listen((event) {
      setState(() {
        lastNumber = event;
      });
    });

    streamSubscription.onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });

    streamSubscription.onDone(() {
      print("OnDone was called");
    });

    super.initState();
  }

  void addRandomNumber() {
    Random random = Random();
    int myNum = random.nextInt(10);
    if (!numberStreamController.isClosed) {
      numberStream.addNumberToSink(newNumber: myNum);
    } else {
      setState(() {
        lastNumber = -1; // throws error number
      });
    }

    //test for errors
    //numberStream.addError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream"),
      ),
      body: Container(
        decoration: BoxDecoration(color: bgColor),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(lastNumber.toString()),
            ElevatedButton(
                onPressed: () {
                  addRandomNumber();
                },
                child: Text("New Random Number")),
            ElevatedButton(
                onPressed: () {
                  stopStream();
                },
                child: Text("Stop Stream"))
          ],
        ),
      ),
    );
  }
}
