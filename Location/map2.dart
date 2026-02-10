import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class Map2 extends StatefulWidget {
  const Map2({super.key});

  @override
  State<Map2> createState() => _Map2State();
}

class _Map2State extends State<Map2> {
  GoogleMapController? _mapController;

  LatLng _currentPosition = const LatLng(
    13.7563, 100.5018
  );

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        _currentPosition = LatLng(
          position.latitude,
          position.longitude,
        );
      } catch (e) {
        debugPrint("Location error: $e");
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition,
          zoom: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map in Flutter'),
        backgroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15,
              ),
             markers: {
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: _currentPosition,
                infoWindow: const InfoWindow(title: 'You are here'),
              ),
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            ),
            
    );
  }
}
