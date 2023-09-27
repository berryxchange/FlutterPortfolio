import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Future Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  late String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Back from the Future"),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  result = "";
                  setState(() {
                    result = result;
                  });
                  getData().then((value) {
                    result = value.body.toString().substring(0, 450);
                    setState(() {
                      result = result;
                    });
                  }).catchError((_) {
                    result = "An error occurred";
                    setState(() {
                      result = result;
                    });
                  });
                },
                child: Text("Go!")),
            Spacer(),
            Text(result.toString()),
            Spacer(),
            CircularProgressIndicator(),
            Spacer()
          ],
        ),
      ),
    );
  }

  Future<http.Response> getData() async {
    final String authority = "www.googleapis.com";
    final String path = "books/v1/volumes/junbDwAAQBAJ";
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }
}
