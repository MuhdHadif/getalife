import 'package:flutter/material.dart';
import 'package:getalife/view/splashscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetALife',
      theme: ThemeData(),
      home: SplashScreen()
    );
  }
}
