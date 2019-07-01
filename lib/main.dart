import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplefire/routes.dart';

void main(){
  //mobile'i roate'e kapattık.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      .then((_) {
    runApp(MyApp());
  });}
var apiKey = "AIzaSyDMaLDcKZ9XSR07dOED9VQo0Sx8XtOTcXU";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Fire',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.pinkAccent,
          fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      routes: routes,
//      home: new MyHomePage(new BasicHomePresenter(), title: 'Flutter Demo Home Page'),
    );
  }
}