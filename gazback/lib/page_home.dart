import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
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
          Saldo(),
        ],
      ),
    );
  }
}

class Saldo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      height: 128,
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
                '   90.990',
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
              Text('Saldo LinkAja',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Rp',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  Text(
                    '3.576.900',
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
                '3285   ',
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
    );
  }
}
