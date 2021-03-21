import 'dart:async';

import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'file:///D:/test/flutter-p/flutter_app/lib/UI/main.dart';
import 'file:///D:/test/flutter-p/flutter_app/lib/UI/main_splash_screen.dart';

class Data {
  final String title;
  final String description;
  final String imageUrl;
  final IconData iconData;

  Data({
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.iconData,
  });
}

class PView extends StatefulWidget {
  @override
  _PViewState createState() => _PViewState();
}

class _PViewState extends State<PView> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  int _currentIndex = 0;
  final _pageIndexNotifier = ValueNotifier<int>(0);

  List<Data> myData = [
    Data(
      title: "Title 1",
      description: "Loeem sipsdnk sjkdwoqld",
      imageUrl: "images/q1.jpg",
      iconData: Icons.add_a_photo,
    ),
    Data(
      title: "Title 2",
      description: "xclo asd dejbde fdndd",
      imageUrl: "images/q2.jpg",
      iconData: Icons.add_a_photo,
    ),
    Data(
      title: "Title 3",
      description: "sfskn fdvfsjkvbs rf rehkw fdfd",
      imageUrl: "images/q3.jpg",
      iconData: Icons.add_a_photo,
    ),
    Data(
      title: "Title 4",
      description: "iohdfd vdskv envehvhd vvd",
      imageUrl: "images/q4.jpg",
      iconData: Icons.add_a_photo,
    ),
  ];

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 6), (timer) {
      if (_currentIndex < 3) _currentIndex++;
      _controller.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/a': (ctx) => MyHomePage(),
        '/b': (ctx) => MainSplashScreen(),
      },
      home: Scaffold(
        body: Stack(alignment: Alignment(0, 0.7), children: [
          Builder(
              builder: (ctx) => PageView(
                    controller: _controller,
                    children: myData
                        .map((item) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: ExactAssetImage(item.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    item.iconData,
                                    size: 130,
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    item.description,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    onPageChanged: (val) {
                      _pageIndexNotifier.value = val;
                      setState(() {
                        _currentIndex = val;
                        /*if (_currentIndex == 3) {
                          Future.delayed(Duration(seconds: 1),
                              () => Navigator.of(ctx).pushNamed('/b'));
                        }*/
                      });
                    },
                  )),
          PageViewIndicator(
            pageIndexNotifier: _pageIndexNotifier,
            length: myData.length,
            normalBuilder: (_, index) => Circle(
              size: 8.0,
              color: Colors.white,
            ),
            highlightedBuilder: (animationController, _) => ScaleTransition(
              scale: CurvedAnimation(
                  parent: animationController, curve: Curves.ease),
              child: Icon(Icons.star),
            ),
          ),
          // Center(child: Indicator(_currentIndex)),
          Builder(
            builder: (ctx) => Align(
              alignment: Alignment(0, 0.93),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(7),
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () async {
                    Navigator.of(ctx).pushNamed('/b');
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('x', true);
                  },
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;

  Indicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(0, index == 0 ? Colors.green : Colors.red),
          buildContainer(1, index == 1 ? Colors.green : Colors.red),
          buildContainer(2, index == 2 ? Colors.green : Colors.red),
          buildContainer(3, index == 3 ? Colors.green : Colors.red),
        ],
      ),
    );
  }

  Widget buildContainer(int i, Color color) {
    return index == i
        ? Icon(Icons.star)
        : Container(
            margin: EdgeInsets.all(4),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          );
  }
}
