import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';

class RouletteScreen extends StatefulWidget {
  @override
  _RouletteScreenState createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> {
  int _poin;
  int _attempt;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot ds = await Firestore.instance
        .collection('pengguna')
        .document(user.uid)
        .get();
    setState(() {
      _poin = ds.data['poin'];
      _attempt = ds.data['attempt_gacha'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roulette'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 16),
            Text(
              'GazPoint',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '${_poin ?? ''}',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Attempt: ${_attempt ?? ''}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Image.asset('img/penunjuk.png'),
            SpinningWheel(
              Image.asset('img/puteran.png'),
              canInteractWhileSpinning: false,
              height: 300,
              width: 300,
              dividers: 6,
              onEnd: (x) {},
              onUpdate: (x) {},
            ),
            SizedBox(height: 64),
            Text(
              'Roulette Attempt',
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Pertalite',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Pertamax',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Pertamax Turbo',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Bio Solar',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Dexlite',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Pertamina Dex',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '3.5 Liter',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '2 Liter',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '1 Liter',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '3 Liter',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '2 Liter',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '1 Liter',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
