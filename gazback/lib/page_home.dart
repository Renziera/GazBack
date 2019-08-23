import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
          Saldo(),
          BrightStore(),
          SizedBox(height: 16),
          Terdekat(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class Terdekat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //Decoration --> BoxDecoration --> Image --> DecorationImage
      color: Colors.indigo,
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
                'SPBU Pertamina 44.551.08',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Jl. Tomang Raya, Palmerah',
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
                onPressed: () {},
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
              Icon(Icons.accessibility),
              Icon(Icons.accessibility),
              Icon(Icons.accessibility),
              Icon(Icons.accessibility),
              RaisedButton(
                child: Text(
                  'GazKan saja!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {},
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
  @override
  _SaldoState createState() => _SaldoState();
}

class _SaldoState extends State<Saldo> {
  int _poin;
  int _saldo;
  int _koin;

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
                    Colors.cyan,
                    Colors.blue,
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
                      Text(
                        'selengkapnya',
                        style: TextStyle(color: Colors.white, fontSize: 10),
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
                      Text(
                        'selengkapnya',
                        style: TextStyle(color: Colors.white, fontSize: 10),
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
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    child: Icon(Icons.ac_unit),
                    onPressed: () {},
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
