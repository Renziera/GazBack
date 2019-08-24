import 'package:firebase_livestream_ml_vision/firebase_livestream_ml_vision.dart';
import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  FirebaseVision _vision;

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
    setState(() {});
  }

  @override
  void dispose() async {
    super.dispose();
    if (_vision != null) await _vision.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: _vision == null
          ? Center(
              child: Text('Initializing camera...'),
            )
          : SizedBox.expand(
              child: FirebaseCameraPreview(_vision),
            ),
    );
  }
}
