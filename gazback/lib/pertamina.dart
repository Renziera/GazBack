import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_livestream_ml_vision/firebase_livestream_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:gazback/splash.dart';

class PertaminaScreen extends StatefulWidget {
  @override
  _PertaminaScreenState createState() => _PertaminaScreenState();
}

class _PertaminaScreenState extends State<PertaminaScreen> {
  FirebaseVision _vision;
  bool _showButton = false;
  String _plat = '';
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    List<FirebaseCameraDescription> cameras = await camerasAvailable();
    _vision = FirebaseVision(cameras[0], ResolutionSetting.high);
    await _vision.initialize();
    if (!mounted) {
      return;
    }
    Stream<VisionText> stream = await _vision.addTextRecognizer();
    stream.listen((data) {
      for (TextBlock block in data.blocks) {
        for (TextLine line in block.lines) {
          final String text = line.text.replaceAll(RegExp(r'\s+'), '');
          if (RegExp(r'^[A-Z]{1,2}\d{1,4}[A-Z]{1,3}$').hasMatch(text)) {
            setState(() {
              _plat = text;
              _showButton = true;
            });
            if (_timer != null) _timer.cancel();
            _timer = Timer(Duration(seconds: 3), () {
              setState(() {
                _plat = '';
                _showButton = false;
              });
            });
            break;
          }
        }
      }
    });
    setState(() {});
  }

  @override
  void dispose() async {
    super.dispose();
    await _vision.dispose();
    _vision.textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pertamina'),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                  (r) => false);
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _vision == null
              ? Center(
                  child: Text('Initializing camera...'),
                )
              : SizedBox.expand(
                  child: FirebaseCameraPreview(_vision),
                ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '$_plat',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                ),
              ),
              SizedBox(height: 16),
              _showButton
                  ? RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BeliBensin(plat: _plat)));
                      },
                      child: Text('ISI'),
                      textColor: Colors.white,
                      color: Colors.blue,
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}

class BeliBensin extends StatefulWidget {
  final String plat;
  const BeliBensin({@required this.plat});
  @override
  _BeliBensinState createState() => _BeliBensinState();
}

class _BeliBensinState extends State<BeliBensin> {
  final _jenisBensin = [
    'Premium',
    'Pertalite',
    'Pertamax',
    'Pertamax Plus',
    'Pertamax Turbo'
  ];
  String _jenisBensinValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengisian Bahan Bakar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('PLAT NOMOR: ${widget.plat}'),
            Text('PEMILIK: JONI'),
            DropdownButton<String>(
              value: _jenisBensinValue,
              onChanged: (String newValue) {
                setState(() {
                  _jenisBensinValue = newValue;
                });
              },
              items: _jenisBensin.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('BATAL'),
                  textColor: Colors.white,
                  color: Colors.red,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('BELI'),
                  textColor: Colors.white,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
