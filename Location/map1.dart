import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map1 extends StatefulWidget {
  const Map1({super.key});

  @override
  State<Map1> createState() => _Map1State();
}

class _Map1State extends State<Map1> {
  GoogleMapController? mapController;
  LatLng _center = const LatLng(38.897971420113585, -77.03659887631505);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map in Flutter'),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
      )
    );
  }
}
