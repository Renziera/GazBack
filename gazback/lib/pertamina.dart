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
  bool _shouldProcess = true;
  String _plat;

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
      if (_shouldProcess) {
        print(data.text);
        _plat = data.text;
        for (TextBlock block in data.blocks) {
          final String text = block.text;
          for (TextLine line in block.lines) {
            RegExp('').hasMatch(line.text);
          }
        }
        setState(() {
          _shouldProcess = false;
        });
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
      body: _vision == null
          ? Center(
              child: Text('Initializing camera...'),
            )
          : _shouldProcess
              ? SizedBox.expand(
                  child: FirebaseCameraPreview(_vision),
                )
              : BeliBensin(),
    );
  }
}

class BeliBensin extends StatefulWidget {
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
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('PLAT NOMOR: AB 7372 QZ'),
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
                onPressed: () {},
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
    );
  }
}
