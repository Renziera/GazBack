import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class KendaraanPage extends StatefulWidget {
  @override
  _KendaraanPageState createState() => _KendaraanPageState();
}

class _KendaraanPageState extends State<KendaraanPage> {
  String _uid;
  @override
  void initState() {
    super.initState();
    _getUid();
  }

  void _getUid() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '  Mobil',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                      child: Text(
                        'Tambahkan Data Mobil',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                TambahKendaraan(isMobil: true)));
                      },
                    )
                  ],
                ),
                _uid != null
                    ? StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('pengguna')
                            .document(_uid)
                            .collection('kendaraan')
                            .where('mobil', isEqualTo: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            default:
                              return ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: snapshot.data.documents
                                    .map((DocumentSnapshot document) {
                                  return ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailKendaraan(
                                                    nama: document['nama'],
                                                    plat: document['plat'],
                                                  )));
                                    },
                                    title: Text(
                                      document['nama'],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      document['plat'],
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.blue),
                                    ),
                                  );
                                }).toList(),
                              );
                          }
                        },
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          SizedBox(height: 24),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '  Motor',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                      child: Text(
                        'Tambahkan Data Motor',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                TambahKendaraan(isMobil: false)));
                      },
                    )
                  ],
                ),
                _uid != null
                    ? StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('pengguna')
                            .document(_uid)
                            .collection('kendaraan')
                            .where('mobil', isEqualTo: false)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            default:
                              return ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: snapshot.data.documents
                                    .map((DocumentSnapshot document) {
                                  return ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailKendaraan(
                                                    nama: document['nama'],
                                                    plat: document['plat'],
                                                  )));
                                    },
                                    title: Text(
                                      document['nama'],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      document['plat'],
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.blue),
                                    ),
                                  );
                                }).toList(),
                              );
                          }
                        },
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailKendaraan extends StatelessWidget {
  final String nama;
  final String plat;
  const DetailKendaraan({@required this.nama, @required this.plat});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Kendaraan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$nama',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$plat',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Image.asset('img/oli.png'),
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 24,
                    ),
                    SizedBox(
                      height: 36,
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CekOli()));
                  },
                  color: Colors.teal.shade300,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Cek Originalitas',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      Text(
                        'Oli Pertamina',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Image.asset('img/placeholder_kendaraan.png'),
          ],
        ),
      ),
    );
  }
}

class CekOli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cek Originalitas Oli'),
      ),
      body: SingleChildScrollView(
        child: Image.asset('img/placeholder_oli.png'),
      ),
    );
  }
}

class TambahKendaraan extends StatelessWidget {
  final bool isMobil;

  const TambahKendaraan({@required this.isMobil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data ${isMobil ? 'Mobil' : 'Motor'}'),
      ),
      body: SingleChildScrollView(
        child: Image.asset('img/placeholder_tambah_kendaraan.png'),
      ),
    );
  }
}
