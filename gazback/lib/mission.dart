import 'package:flutter/material.dart';

class MissionScreen extends StatefulWidget {
  @override
  _MissionScreenState createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mission'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'MISI BARU'),
              Tab(text: 'MISI BERJALAN'),
              Tab(text: 'MISI SELESAI'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Image.asset('img/misi-baru.png'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Image.asset('img/misi-berjalan-1.png'),
                  SizedBox(height: 8),
                  Image.asset('img/misi-berjalan-2.png'),
                ],
              ),
            ),
            Center(child: Text('Belum ada misi yang diselesaikan')),
          ],
        ),
      ),
    );
  }
}
