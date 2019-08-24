import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gazback/mission.dart';
import 'package:gazback/peta.dart';
import 'package:gazback/roulette.dart';
import 'package:gazback/scan.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatelessWidget {
  final setPage;
  HomePage(this.setPage);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Cari Produk dan Jasa Pertamina',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
          SizedBox(height: 16),
          Saldo(setPage),
          BrightStore(setPage),
          SizedBox(height: 16),
          Terdekat(),
          SizedBox(height: 16),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '   Spesial Untukmu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        'Lihat Semua',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 156,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 16),
                        Image.asset('img/poster-1.png'),
                        SizedBox(width: 16),
                        Image.asset('img/poster-2.png'),
                        SizedBox(width: 16),
                        Image.asset('img/poster-3.png'),
                        SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Tambah Kesempatan Menang',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset('img/roulette.png'),
                        SizedBox(height: 8),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RouletteScreen()));
                          },
                          color: Colors.teal.shade300,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Roulette',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'GazPoint',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Image.asset('img/daily.png'),
                        SizedBox(height: 8),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GazKoin()));
                          },
                          color: Colors.teal.shade300,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Collect Daily',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'GazKoin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          SizedBox(height: 16),
          FlatButton(
            padding: EdgeInsets.all(0),
            child: Image.asset('img/mission.png'),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MissionScreen()));
            },
          ),
        ],
      ),
    );
  }
}

class GazKoin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily GazCoin'),
      ),
      body: Image.asset('img/placeholder_gazcoin.png'),
    );
  }
}

class Terdekat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('img/pertamina.png'), fit: BoxFit.cover)),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'SPBU Terdekat',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'SPBU Pertamina Jakarta Pusat',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Jl. Abdul Muis 59, Petojo',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'JAKARTA PUSAT',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '±1 km',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              RaisedButton(
                child: Text(
                  'Get Direction',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PetaPertamina()));
                },
                color: Colors.teal.shade300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BrightStore extends StatelessWidget {
  final setPage;
  BrightStore(this.setPage);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Repot antri udah gak jaman!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('img/snack-1.png'),
              Image.asset('img/snack-2.png'),
              Image.asset('img/snack-3.png'),
              Image.asset('img/snack-4.png'),
              Image.asset('img/snack-5.png'),
              RaisedButton(
                child: Text(
                  'GazKan saja!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  setPage(2);
                },
                color: Colors.teal.shade300,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Kini anda dapat dengan mudah membeli produk BrightStore Pertamina',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class Saldo extends StatefulWidget {
  final setPage;
  Saldo(this.setPage);
  @override
  _SaldoState createState() => _SaldoState();
}

class _SaldoState extends State<Saldo> {
  int _poin;
  int _saldo;
  int _koin;
  String _uid;

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
      _uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF00A7C6),
                    Color(0xFF2080B5),
                  ],
                ),
              ),
              height: 156,
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('GazPoint', style: TextStyle(color: Colors.white)),
                      Text(
                        '   ${_poin ?? ''}',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Saldo LinkAja',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Rp',
                            style: TextStyle(color: Colors.yellow),
                          ),
                          Text(
                            '${_saldo ?? ''}',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text('Premium Member',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('GazCoin', style: TextStyle(color: Colors.white)),
                      Text(
                        '${_koin ?? ''}   ',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 56),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 16),
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
                          'img/prize.png',
                          height: 48,
                          width: 48,
                        ),
                        Text(
                          'Ambil Hadiah',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    onPressed: () {
                      widget.setPage(3);
                    },
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
