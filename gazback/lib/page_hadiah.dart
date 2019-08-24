import 'package:flutter/material.dart';

class HadiahPage extends StatefulWidget {
  @override
  _HadiahPageState createState() => _HadiahPageState();
}

class _HadiahPageState extends State<HadiahPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.blue,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  TabBar(
                    tabs: [
                      Tab(text: 'GazCoin'),
                      Tab(text: 'GazPoint'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pertamina',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Image.asset('img/coin-pertamina-1.png'),
                    SizedBox(height: 8),
                    Image.asset('img/coin-pertamina-2.png'),
                    SizedBox(height: 8),
                    Image.asset('img/coin-pertamina-3.png'),
                    SizedBox(height: 8),
                    Image.asset('img/coin-pertamina-4.png'),
                    SizedBox(height: 16),
                    Text(
                      'Partner',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Image.asset('img/coin-umkm-1.png'),
                    SizedBox(height: 8),
                    Image.asset('img/coin-umkm-2.png'),
                    SizedBox(height: 8),
                    Image.asset('img/coin-umkm-3.png'),
                    SizedBox(height: 16),
                    Text(
                      'Undian',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Image.asset('img/coin-undian-1.png'),
                    SizedBox(height: 8),
                    Image.asset('img/coin-undian-2.png'),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pertamina',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Image.asset('img/poin-pertamina-1.png'),
                    SizedBox(height: 8),
                    Image.asset('img/poin-pertamina-2.png'),
                    SizedBox(height: 8),
                    Image.asset('img/poin-pertamina-3.png'),
                    SizedBox(height: 8),
                    Image.asset('img/poin-pertamina-4.png'),
                    SizedBox(height: 16),
                    Text(
                      'Partner',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Image.asset('img/poin-umkm-1.png'),
                    SizedBox(height: 8),
                    Image.asset('img/poin-umkm-2.png'),
                    SizedBox(height: 8),
                    Image.asset('img/poin-umkm-3.png'),
                    SizedBox(height: 16),
                    Text(
                      'Undian',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Image.asset('img/poin-undian-1.png'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
