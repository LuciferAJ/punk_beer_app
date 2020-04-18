import 'package:flutter/material.dart';
import 'package:punkbeerapp/screens/home_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.black,textTheme:TextTheme(headline1:TextStyle(color: Colors.white))),),
    );
  }
}
