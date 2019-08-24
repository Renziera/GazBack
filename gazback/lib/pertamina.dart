import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
                        String copyPlat = _plat.toString();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BeliBensin(plat: copyPlat)));
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
    'Pertamax Turbo',
    'Bio Solar',
    'Dexlite',
    'Pertamina Dex'
  ];

  final _hargaBensin = [
    7000,
    7650,
    9850,
    11200,
    9800,
    10200,
    11700,
  ];

  final TextEditingController _literController = TextEditingController();
  String _jenisBensinValue;
  int _harga;
  String _namaPemilik = 'TIDAK TERDAFTAR';
  DocumentReference _docRefPengguna;
  DocumentReference _docRefKendaraan;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    QuerySnapshot snapshots = await Firestore.instance
        .collection('kendaraan_terdaftar')
        .where('plat', isEqualTo: widget.plat)
        .getDocuments();
    if (snapshots.documents.isEmpty) return;
    DocumentSnapshot ds = snapshots.documents.first;
    DocumentSnapshot pengguna = await Firestore.instance
        .collection('pengguna')
        .document(ds.data['pengguna_id'])
        .get();
    _docRefPengguna = pengguna.reference;
    _docRefKendaraan =
        pengguna.reference.collection('kendaraan').document(ds.documentID);
    setState(() {
      _namaPemilik = pengguna.data['nama'];
    });
  }

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
            Text(
              'PLAT NOMOR: ${widget.plat}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'PEMILIK: $_namaPemilik',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropdownButton<String>(
                  value: _jenisBensinValue,
                  hint: Text('Bahan Bakar'),
                  onChanged: (String value) {
                    setState(() {
                      _jenisBensinValue = value;
                    });
                  },
                  items: _jenisBensin
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                _jenisBensinValue != null
                    ? Text(
                        'Rp${_hargaBensin[_jenisBensin.indexOf(_jenisBensinValue)]},00')
                    : SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 96,
                      child: TextField(
                        controller: _literController,
                        onSubmitted: (s) {
                          if (_jenisBensinValue == null) return;
                          _harga = (_hargaBensin[
                                      _jenisBensin.indexOf(_jenisBensinValue)] *
                                  num.parse(s))
                              .round();
                          setState(() {});
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Text('L'),
                  ],
                ),
                _harga != null ? Text('Rp$_harga,00') : SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  onPressed: () async {
                    if (_harga == null) return;
                    Navigator.of(context).pop();
                    if (_docRefKendaraan == null) return;
                    await _docRefPengguna.updateData({
                      'saldo': FieldValue.increment(-_harga),
                      'attempt_gacha':
                          FieldValue.increment(double.parse(_literController.text).floor())
                    });
                    await _docRefKendaraan.collection('pengisian').add({
                      'keterangan':
                          'Pengisian $_jenisBensinValue ${_literController.text}L',
                      'harga': _harga,
                      'waktu': FieldValue.serverTimestamp(),
                    });
                  },
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
