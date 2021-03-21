import 'package:flutter/material.dart';
import 'file:///D:/test/flutter-p/flutter_app/lib/UI/main_splash_screen.dart';
import 'package:flutter_app/UI/my_color.dart';
import 'package:flutter_app/UI/pageView.dart';
import 'package:toast/toast.dart';
import 'package:flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool decision = prefs.getBool('x');
  Widget _screen =
      (decision == false || decision == null) ? PView() : MyHomePage();
  runApp(_screen);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      darkTheme:
          ThemeData(primaryColor: Colors.blue, canvasColor: Colors.black),
      theme: ThemeData(canvasColor: Colors.white, primaryColor: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _x = GlobalKey<ScaffoldState>();
  String str = "Flutter Demo";
  List imgList = [
    'images/s1.jpg',
    'images/s2.jpg',
    'images/s3.jpg',
  ];
  int _radioValue = 0;
  int _currentIndex;
  String result;
  Color resColor;

  bool js = false;
  bool cSharp = false;
  bool python = false;

  String get txt {
    String str = "You selected:\n";
    if (js == true) str += "JavaScript\n";
    if (python == true) str += "Python\n";
    if (cSharp == true)
      str += "C#\n";
    else
      str += "None\n";
    return str;
  }

  ThemeMode tm = ThemeMode.light;
  bool _swVal = false;
  String _selectedLetter;
  List _letterList = ["A", "B", "C", "D", "E"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: tm,
      darkTheme:
          ThemeData(primaryColor: Colors.blue, canvasColor: Colors.black),
      theme: ThemeData(canvasColor: Colors.white, primaryColor: Colors.blue),
      home: Scaffold(
        key: _x,
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {},
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.deepPurpleAccent,
              Colors.pink,
              Colors.deepPurpleAccent
            ])),
          ),
          centerTitle: true,
          title: Text(
            str,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Center(
          child: MyColor(
            color: Colors.amber,
            child: Builder(
              builder: (ctx) => Text(
                "My Text",
                style: TextStyle(
                    backgroundColor: MyColor.of(ctx).color, fontSize: 45),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView buildExpansionTile() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ExpansionTile(
            backgroundColor: Colors.blueGrey,
            leading: Icon(Icons.perm_identity),
            title: Text("Account"),
            children: [
              Divider(
                color: Colors.grey,
              ),
              Card(
                color: Colors.grey,
                child: ListTile(
                  leading: Icon(Icons.add),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text("Sign Up!"),
                  subtitle: Text("Where you can register an account"),
                  onTap: buildSnackBar,
                ),
              ),
              Card(
                color: Colors.grey,
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text("Sign In!"),
                  subtitle: Text("Where you can Login with an account"),
                  onTap: buildSnackBar,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ExpansionTile(
            backgroundColor: Colors.blueGrey,
            title: Text("More Info"),
            leading: Icon(Icons.message),
            children: [
              Divider(
                color: Colors.grey,
              ),
              Card(
                color: Colors.grey,
                child: ListTile(
                  leading: Icon(Icons.phone),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text("Contact"),
                  subtitle: Text("Where you can call us"),
                  onTap: buildSnackBar,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Center buildDropDownButton() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Select A Letter!"),
          DropdownButton(
            hint: Text("  Select Letter!"),
            items: _letterList
                .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                .toList(),
            value: _selectedLetter,
            onChanged: (val) {
              setState(() {
                _selectedLetter = val;
              });
            },
          )
        ],
      ),
    );
  }

  Center buildSwitch() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text("Light"),
          ),
          Switch(
            value: _swVal,
            onChanged: (bool value) {
              setState(() {
                _swVal = value;
                if (_swVal == false)
                  tm = ThemeMode.light;
                else
                  tm = ThemeMode.dark;
              });
            },
            activeColor: Colors.red,
            inactiveThumbColor: Colors.blue,
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text("Dark"),
          ),
        ],
      ),
    );
  }

  Padding buildCheckbox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text("Select All the programming languages you know:"),
          Row(
            children: [
              Checkbox(
                value: python,
                onChanged: (value) {
                  setState(() {
                    python = value;
                  });
                },
              ),
              Text("Python"),
            ],
          ),
          CheckboxListTile(
            value: js,
            onChanged: (value) {
              setState(() {
                js = value;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            title: Text("JS"),
          ),
          CheckboxListTile(
            value: cSharp,
            onChanged: (value) {
              setState(() {
                cSharp = value;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            title: Text("C#"),
          ),
          ElevatedButton(
            onPressed: () {
              var ad = AlertDialog(
                title: Text("Thank you for applying!"),
                content: Text(txt),
              );
              showDialog(context: context, builder: (_) => ad);
            },
            child: Text("Apply!"),
          )
        ],
      ),
    );
  }

  RadioListTile buildRadioListTile(val, txt, subTxt) {
    return RadioListTile(
      controlAffinity: ListTileControlAffinity.platform,
      value: val,
      groupValue: _radioValue,
      onChanged: (v) {
        setState(() {
          _radioValue = v;
        });
      },
      title: Text(txt),
      subtitle: Text(
        subTxt,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Padding buildRadioButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Guess the answer : 9^2 ???",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.lightBlue),
          ),
          buildRow(3),
          buildRow(pow(9, 2)),
          buildRow(72),
        ],
      ),
    );
  }

  myDialog() {
    var ad = AlertDialog(
      content: Container(
        height: 100,
        child: Column(
          children: [
            Text("$result", style: TextStyle(color: resColor)),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Answer is :81"),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (_) => ad);
  }

  Row buildRow(int value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _radioValue,
          onChanged: (value) {
            setState(() {
              result = value == 81 ? "Correct Answer" : "Wrong Answer";
              resColor = value == 81 ? Colors.green : Colors.red;
              _radioValue = value;
              myDialog();
            });
          },
        ),
        Text("$value"),
      ],
    );
  }

  ListView buildCarousel() {
    return ListView(
      children: [
        SizedBox(height: 30),
        Text(
          "Slider 1: Initial Page Index 0\n\n",
          textAlign: TextAlign.center,
        ),
        CarouselSlider(
          items: imgList.map((img) {
            return Container(
              width: double.infinity,
              child: Image.asset(
                img,
                fit: BoxFit.fill,
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 186,
            initialPage: 0,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            enableInfiniteScroll: false,
            pauseAutoPlayOnTouch: false,
            onPageChanged: (int i, _) {
              setState(() {
                _currentIndex = i;
              });
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildContainer(0),
            buildContainer(1),
            buildContainer(2),
          ],
        ),
        SizedBox(height: 30),
        Text(
          "Slider 2: Initial Page Index 1\n\n",
          textAlign: TextAlign.center,
        ),
        CarouselSlider.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              child: Image.asset(imgList[index], fit: BoxFit.fill),
            );
          },
          itemCount: imgList.length,
          options: CarouselOptions(
            height: 186,
            initialPage: 1,
            enlargeCenterPage: true,
          ),
        ),
      ],
    );
  }

  Container buildContainer(index) {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.redAccent : Colors.green,
      ),
    );
  }

  Column someTextProperty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SelectableText(
          "I'm copyable",
          style: TextStyle(fontWeight: FontWeight.bold),
          showCursor: true,
          cursorWidth: 10,
          cursorColor: Colors.red,
          toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
        ),
        Container(
          height: 40,
          color: Colors.green,
          child: Text(
            "This is a clipped text.This is a clipped text.This is a clipped text.",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            overflow: TextOverflow.fade,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 40,
          color: Colors.green,
          child: Text(
            "This is a clipped text.This is a clipped text.This is a clipped text.",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            overflow: TextOverflow.visible,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 40,
          color: Colors.green,
          child: Text(
            "This is a clipped text.This is a clipped text.This is a clipped text.",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            overflow: TextOverflow.clip,
            softWrap: false,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 40,
          color: Colors.green,
          child: Text(
            "This is a clipped text.This is a clipped text.This is a clipped text.",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void buildFlushbar(BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      mainButton: TextButton(
        child: Text("undo"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.info,
        color: Colors.white,
      ),
      backgroundColor: Colors.amber,
      title: "This is the title",
      messageText: Text(
        "Hello Flutter",
        style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
      ),
    ).show(context);
  }

  void buildSnackBar() {
    final sBar = SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Text("SnackBar Text"),
      action: SnackBarAction(
        textColor: Colors.black,
        label: "Undo!",
        onPressed: () {
          setState(() {
            str = "Flutter Demo";
          });
        },
      ),
    );
    _x.currentState.showSnackBar(sBar);
  }

  void buildAlertDialog(BuildContext context) {
    final AlertDialog alert = AlertDialog(
        title: Text("Dialog Title"),
        content: Container(
          height: 150,
          child: Column(
            children: [
              Divider(
                color: Colors.black,
              ),
              Text("Dialog Text appear Here"),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    primary: Colors.red,
                  ),
                  child: Text(
                    "close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ));

    showDialog(
      context: context,
      builder: (_) => alert,
      barrierDismissible: false,
      barrierColor: Colors.red.withOpacity(0.3),
    );
  }

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        buildSliverAppBar(),
        SliverList(delegate: SliverChildListDelegate([])),
      ],
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 100,
      leading: Padding(
        padding: EdgeInsets.only(left: 1),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {},
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.deepPurpleAccent,
          Colors.pink,
          Colors.deepPurpleAccent
        ])),
      ),
      centerTitle: true,
      title: Text(
        "Flutter Demo",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  FlatButton buildFlatButton(BuildContext context) {
    return FlatButton(
      onPressed: () => showToast(context),
      child: buildRichText(),
    );
  }

  void showToast(BuildContext context) {
    Toast.show(
      "Pink/Amber",
      context,
      duration: Toast.LENGTH_LONG,
      gravity: 0,
      backgroundColor: Colors.amber,
      textColor: Colors.pink,
      backgroundRadius: 4,
    );
  }

  RichText buildRichText() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: "Pink",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 35, color: Colors.pink)),
        TextSpan(
            text: "/",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.black)),
        TextSpan(
            text: "Amber",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.amber)),
      ]),
    );
  }
}
