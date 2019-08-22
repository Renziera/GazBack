import 'package:flutter/material.dart';
import 'package:gazback/splash.dart';

const String NOMOR_PERTAMINA = '+628111222333';

void main() => runApp(GazBack());

class GazBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GazBack',
      home: SplashScreen(),
      theme: ThemeData(
        accentColor: Colors.blueAccent,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        fontFamily: 'Livvic',
      ),
    );
  }
}