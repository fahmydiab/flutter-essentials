import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';

void main() {
  final Future<int> myFuture =
      Future.delayed(Duration(seconds: 1), () => info(2));
  print(1);
  print(1);
  runApp(MyHomePage());
}

int info(int a) {
  return a;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(canvasColor: Colors.white, primaryColor: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 2), () => info(2)),
        builder: (ctx, snapShot) {
          return Scaffold(
            appBar: AppBar(
                title: Text(snapShot.hasData ? "${snapShot.data}" : "Demo")),
            body: Center(
              child: snapShot.connectionState == ConnectionState.waiting
                  ? CircularProgressIndicator()
                  : Text("done !"),
            ),
          );
        },
      ),
    );
  }
}

blockApp(int sec) {
  print("Begin");
  sleep(Duration(seconds: sec));
  print("End");
}
