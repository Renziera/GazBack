import 'package:flutter/material.dart';
import 'package:gazback/page_home.dart';

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
      SizedBox.shrink(),
      SizedBox.shrink(),
      SizedBox.shrink(),
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
              'img/prize-pale.png',
              height: 24,
              width: 24,
            ),
            activeIcon: Image.asset(
              'img/prize-color.png',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
    );
  }
}

/*
final CameraPosition _initialPos = CameraPosition(
    target: LatLng(-7.7753915, 110.3777944),
    zoom: 16,
  );
  PermissionHandler()
                  .requestPermissions([PermissionGroup.location]);
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                  (r) => false);
*/
