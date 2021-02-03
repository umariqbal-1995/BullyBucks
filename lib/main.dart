import 'package:flutter/material.dart';
import 'Widgets/buttonRound.dart';
import 'Widgets/Logo.dart';
import 'package:bully_bucks/Flow/Auth/Login/logingender.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginGender(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 219, 152, 1),
      body:Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              children: [Padding(padding: EdgeInsets.fromLTRB(0, 150, 0, 0)),
                Text("Welcome to Bully Bucks",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonRound(text:"Register",onPress: (){},),
              ButtonRound(text: "Login",onPress: (){},),
            ],
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Logo(),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 40))
          ],
        )
        ],
      ),
    );
  }
}
