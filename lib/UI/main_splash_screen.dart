import 'package:flutter/material.dart';
import 'file:///D:/test/flutter-p/flutter_app/lib/UI/main.dart';
import 'package:splashscreen/splashscreen.dart';

class MainSplashScreen extends StatefulWidget {
  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(
          seconds: 3,
          loaderColor: Colors.yellow,
          backgroundColor: Colors.blueAccent,
          image: Image.asset('images/s1.jpg'),
          photoSize: 180,
          loadingText: Text("Getting Page Ready!"),
          title: Text("Splash Screen Tutorial"),
          navigateAfterSeconds: MyHomePage(),
        ),
      ),
    );
  }
}
