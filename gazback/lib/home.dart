import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gazback/splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CameraPosition _initialPos = CameraPosition(
    target: LatLng(-7.7753915, 110.3777944),
    zoom: 16,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GazBack',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              PermissionHandler()
                  .requestPermissions([PermissionGroup.location]);
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                  (r) => false);
            },
            child: Text('Hmm'),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPos,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
