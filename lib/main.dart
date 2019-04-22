import 'package:flutter/material.dart';
import 'package:local_loan/pages/splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScreenPage(),
      debugShowCheckedModeBanner: false,
      // darkTheme: ThemeData.dark(),
    );
  }
}
