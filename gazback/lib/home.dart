import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gazback/page_akun.dart';
import 'package:gazback/page_gazkan.dart';
import 'package:gazback/page_hadiah.dart';
import 'package:gazback/page_home.dart';
import 'package:gazback/page_kendaraan.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  static List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(setPage),
      KendaraanPage(),
      GazkanPage(),
      HadiahPage(),
      AkunPage(),
    ];
  }

  void setPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'img/gazback.png',
          height: 24,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            iconSize: 36,
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HistoryScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            iconSize: 36,
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationScreen()));
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'img/home-pale.png',
              height: 24,
              width: 24,
            ),
            activeIcon: Image.asset(
              'img/home-color.png',
              height: 24,
              width: 24,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'img/kendaraan-pale.png',
              height: 24,
              width: 24,
            ),
            activeIcon: Image.asset(
              'img/kendaraan-color.png',
              height: 24,
              width: 24,
            ),
            title: Text('Kendaraan'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'img/gazkan-pale.png',
              height: 24,
              width: 24,
            ),
            activeIcon: Image.asset(
              'img/gazkan-color.png',
              height: 24,
              width: 24,
            ),
            title: Text('GazKan!'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'img/prize-pale.png',
              height: 24,
              width: 24,
            ),
            activeIcon: Image.asset(
              'img/prize-color.png',
              height: 24,
              width: 24,
            ),
            title: Text('Hadiah'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'img/profile-pale.png',
              height: 24,
              width: 24,
            ),
            activeIcon: Image.asset(
              'img/profile-color.png',
              height: 24,
              width: 24,
            ),
            title: Text('Akun'),
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: Center(
        child: Text('Belum ada notifikasi'),
      ),
    );
  }
}

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _uid;

  @override
  void initState() {
    super.initState();
    _getUid();
  }

  void _getUid() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: _uid != null
          ? StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('pengguna')
                  .document(_uid)
                  .collection('transaksi')
                  .orderBy('waktu', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        Timestamp waktu = document['waktu'];
                        DateTime date = waktu.toDate().toLocal();
                        return ListTile(
                          title: Text(document['keterangan']),
                          subtitle: Text(
                              'Rp${document['harga']},00\n${hari[date.weekday - 1]}, ${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}'),
                          isThreeLine: true,
                        );
                      }).toList(),
                    );
                }
              },
            )
          : SizedBox.shrink(),
    );
  }
}

const hari = const [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu'
];
