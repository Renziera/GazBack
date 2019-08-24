import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';

class RouletteScreen extends StatefulWidget {
  @override
  _RouletteScreenState createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roulette'),
      ),
      body: Center(
        child: SpinningWheel(
          Image.asset('img/puteran.png'),
          canInteractWhileSpinning: false,
          height: double.infinity,
          width: double.infinity,
          dividers: 6,
          onEnd: (s) {},
          onUpdate: (s) {},
        ),
      ),
    );
  }
}
