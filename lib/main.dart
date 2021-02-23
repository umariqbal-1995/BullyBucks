import 'dart:developer';
import 'dart:math';
import 'package:bully_bucks/Flow/Auth/Login/loginPage.dart';
import 'package:bully_bucks/Flow/Screens/Reports.dart';
import 'package:bully_bucks/Flow/Screens/reportPage.dart';
import 'package:bully_bucks/Flow/Screens/teacherHomeScreen.dart';
import 'package:flutter/material.dart';
import 'Widgets/buttonRound.dart';
import 'Widgets/Logo.dart';
import 'package:bully_bucks/Flow/Auth/Login/loginGender.dart';
import 'package:bully_bucks/Flow/Auth/Signup/registerPage.dart';
import 'package:bully_bucks/Flow/Screens/studentHomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:bully_bucks/Firebase.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    options:  FirebaseOptions(
      appId: '1:684373091254:android:65f3e8a105e2fe2a585717',
      apiKey: 'AIzaSyDQj7ce3Fd5dW1selv6zVZIlapoP46bkug',
      projectId: 'bullybuck',
      databaseURL: 'https://bullybucks-default-rtdb.firebaseio.com',
        messagingSenderId:"684373091254"
    ));
  FirebaseDatabase database=FirebaseDatabase(app: app);
  Database.database=database;
  Database db=new Database();
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
      debugShowCheckedModeBanner: false,
      home: TeacherHomeePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.app}) : super(key: key);
  final FirebaseApp app;
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseDatabase database=FirebaseDatabase(app: widget.app);
    Database.database=database;
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 219, 152, 1),
      body:Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              children: [Padding(padding: EdgeInsets.fromLTRB(0, 150, 0, 0)),
                Text("Welcome to bully Bucks",
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
              ButtonRound(text:"Register",onPress: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentRegister()),
                );
              },),
              ButtonRound(text: "Login",onPress: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },),
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
