import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gazback/scan.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AkunScreen extends StatefulWidget {
  @override
  _AkunScreenState createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Detail(),
          Container(
            color: Colors.white,
            height: 128,
          ),
        ],
      ),
    );
  }
}

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int _poin;
  int _saldo;
  int _koin;
  String _uid;
  String _nama;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot ds = await Firestore.instance
        .collection('pengguna')
        .document(user.uid)
        .get();
    setState(() {
      _poin = ds.data['poin'];
      _saldo = ds.data['saldo'];
      _koin = ds.data['koin'];
      _nama = ds.data['nama'];
      _uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Saldo LinkAja',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 24),
                          Text(
                            'Rp',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${_saldo ?? ''}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'GazPoint',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        '    ${_poin ?? ''}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'GazKoin',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        '    ${_koin ?? ''}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        size: 64,
                      ),
                      Text(
                        '${_nama ?? ''}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Premium Member',
                        style: TextStyle(color: Colors.blue),
                      ),
                      FlatButton(
                        child: Text(
                          'Edit Profil',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 64),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 48,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        children: <Widget>[
                          Image.asset('img/terima.png'),
                          Text(
                            'Terima',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(child: Text('QR Anda')),
                                content: SizedBox(
                                  height: 256,
                                  width: 256,
                                  child: Center(
                                    child: QrImage(
                                      data: '$_uid',
                                      size: 256,
                                      embeddedImageStyle: QrEmbeddedImageStyle(
                                          size: Size.square(32)),
                                      embeddedImage:
                                          AssetImage('img/logo_gazback.png'),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    child: VerticalDivider(
                      color: Colors.black,
                    ),
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'img/membership.png',
                          height: 48,
                          width: 48,
                        ),
                        Text(
                          'Extend Membership',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 48,
                    child: VerticalDivider(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        children: <Widget>[
                          Image.asset('img/scan.png'),
                          Text(
                            'Scan',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScanScreen()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
