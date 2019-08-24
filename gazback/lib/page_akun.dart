import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gazback/scan.dart';
import 'package:gazback/splash.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AkunPage extends StatefulWidget {
  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Detail(),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset('img/protect.png'),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'GazBack Protection',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        Text(
                          'Protected',
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '84 Days Left!',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '15 November 2019',
                          style: TextStyle(color: Colors.blue, fontSize: 28),
                        ),
                        FlatButton(
                          child: Text(
                            'Extend Membership',
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()),
                                (r) => false);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Image.asset('img/partner.png'),
                    Text(
                      'Diskon Khusus\nPartner Pertamina',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Voucher()));
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 28),
                  child: Column(
                    children: <Widget>[
                      Image.asset('img/voucher.png'),
                      Text(
                        'GazBack\nVoucher',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset('img/toilet.png'),
                Column(
                  children: <Widget>[
                    Text(
                      'Toilet Bersih\nRestroom Nyaman',
                      style: TextStyle(color: Colors.blue, fontSize: 24),
                    ),
                    Text(
                      'Khusus Premium Member GazBck',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    RaisedButton(
                      color: Colors.teal.shade300,
                      child: Text(
                        'Buka Pintu',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScanScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Text(
                  'GazMan Daily Conversation',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(
                  'August 2019 Series',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Image.asset('img/stiker.png'),
                RaisedButton(
                  color: Colors.teal.shade300,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Claim',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        'Sticker',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  onPressed: () {
                    launch(
                        'https://store.line.me/stickershop/product/1484841/id');
                  },
                ),
              ],
            ),
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

class Voucher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GazBack Voucher'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Image.asset('img/voucher-1.png'),
              SizedBox(height: 8),
              Image.asset('img/voucher-2.png'),
              SizedBox(height: 8),
              Image.asset('img/voucher-3.png'),
            ],
          ),
        ),
      ),
    );
  }
}
