import 'package:flutter/material.dart';
import 'package:gazback/splash.dart';

void main() => runApp(GazBack());

class GazBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}