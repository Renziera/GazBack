import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gazback/home.dart';
import 'package:gazback/login.dart';
import 'package:gazback/main.dart';
import 'package:gazback/pertamina.dart';

class SplashScreen extends StatelessWidget {
  void start(context) async {
    await Future.delayed(Duration(milliseconds: 500));
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
      return;
    }
    if (user.phoneNumber == NOMOR_PERTAMINA) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PertaminaScreen()));
      return;
    }
    DocumentSnapshot ds = await Firestore.instance
        .collection('pengguna')
        .document(user.uid)
        .get();
    if (ds.exists) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()), (r) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => NewUserScreen()),
          (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    start(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Center(
          child: Image.asset(
            'img/gazback.png',
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
