import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class PetaPertamina extends StatefulWidget {
  @override
  _PetaPertaminaState createState() => _PetaPertaminaState();
}

class _PetaPertaminaState extends State<PetaPertamina> {
  final CameraPosition _initialPos = CameraPosition(
    target: LatLng(-6.1835675, 106.8238547),
    zoom: 15,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    PermissionHandler().requestPermissions([PermissionGroup.location]);
    QuerySnapshot snapshot =
        await Firestore.instance.collection('pertamina').getDocuments();
    snapshot.documents.forEach((ds) {
      var data = ds.data;
      MarkerId markerId = MarkerId(ds.documentID);
      GeoPoint geoPoint = data['lokasi'];
      Marker marker = Marker(
        markerId: markerId,
        position: LatLng(geoPoint.latitude, geoPoint.longitude),
        infoWindow: InfoWindow(
            title: '${data['nama']}',
            snippet: 'Antrian: ${data['antrian']}',
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('${data['nama']}'),
                      content: Text(
                          '${data['jalan']}\n\nAntrian: ${data['antrian']}'),
                    );
                  });
            }),
      );
      markers[markerId] = marker;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pertamina Terdekat'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPos,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}
