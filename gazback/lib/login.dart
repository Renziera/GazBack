import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gazback/home.dart';
import 'package:gazback/main.dart';
import 'package:gazback/pertamina.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nomorController = TextEditingController();
  final TextEditingController _kodeController = TextEditingController();
  bool _isNomor = true;
  String _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GazBack Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(64.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _isNomor
              ? <Widget>[
                  Text('Silahkan masukkan nomor telepon anda.'),
                  TextField(
                    controller: _nomorController,
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  RaisedButton(
                    onPressed: () async {
                      _auth.verifyPhoneNumber(
                        phoneNumber: _nomorController.text,
                        timeout: const Duration(minutes: 1),
                        codeAutoRetrievalTimeout: (s) => _verificationId = s,
                        codeSent: (s, [i]) {
                          _verificationId = s;
                          setState(() {
                            _isNomor = false;
                          });
                        },
                        verificationFailed: (e) => print(e.message),
                        verificationCompleted:
                            (AuthCredential credential) async {
                          AuthResult result =
                              await _auth.signInWithCredential(credential);
                          if (result.user == null) return;
                          if (result.user.phoneNumber == NOMOR_PERTAMINA) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => PertaminaScreen()),
                                (r) => false);
                          } else {
                            DocumentSnapshot ds = await Firestore.instance
                                .collection('pengguna')
                                .document(result.user.uid)
                                .get();
                            if (ds.exists) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (r) => false);
                            } else {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => NewUserScreen()),
                                  (r) => false);
                            }
                          }
                        },
                      );
                    },
                    child: Text('KIRIM KODE'),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ]
              : <Widget>[
                  Text('Silahkan masukkan kode verifikasi.'),
                  TextField(
                    controller: _kodeController,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  RaisedButton(
                    onPressed: () async {
                      final AuthCredential credential =
                          PhoneAuthProvider.getCredential(
                        verificationId: _verificationId,
                        smsCode: _kodeController.text,
                      );
                      AuthResult result =
                          await _auth.signInWithCredential(credential);
                      if (result.user == null) return;
                      if (result.user.phoneNumber == NOMOR_PERTAMINA) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => PertaminaScreen()),
                            (r) => false);
                      } else {
                        DocumentSnapshot ds = await Firestore.instance
                            .collection('pengguna')
                            .document(result.user.uid)
                            .get();
                        if (ds.exists) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (r) => false);
                        } else {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => NewUserScreen()),
                              (r) => false);
                        }
                      }
                    },
                    child: Text('LOGIN'),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
        ),
      ),
    );
  }
}

class NewUserScreen extends StatefulWidget {
  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pengguna'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Nama'),
            TextField(
              controller: _controller,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            RaisedButton(
              onPressed: () async {
                if (_controller.text.isEmpty) return;
                FirebaseUser user = await FirebaseAuth.instance.currentUser();
                await Firestore.instance
                    .collection('pengguna')
                    .document(user.uid)
                    .setData({
                  'nama': _controller.text,
                  'saldo': 250000,
                  'poin': 1500,
                  'koin': 100,
                });
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (r) => false);
              },
              child: Text('SUBMIT'),
              color: Colors.blue,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
