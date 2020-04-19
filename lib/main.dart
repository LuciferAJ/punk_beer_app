import 'package:flutter/material.dart';
import './services/signin.dart';

void main()async {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.black,textTheme:TextTheme(headline1:TextStyle(color: Colors.white))),),
    );
  }
}
