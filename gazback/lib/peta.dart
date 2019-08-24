import 'package:flutter/material.dart';

class PetaPertamina extends StatefulWidget {
  @override
  _PetaPertaminaState createState() => _PetaPertaminaState();
}

class _PetaPertaminaState extends State<PetaPertamina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pertamina Terdekat'),
      ),
    );
  }
}
