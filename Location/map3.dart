import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Map3 extends StatefulWidget {
  const Map3({super.key});

  @override
  State<Map3> createState() => _Map3State();
}

class _Map3State extends State<Map3> {
  GoogleMapController? _mapController;

  LatLng _currentPosition = const LatLng(13.7563, 100.5018);
  bool _isLoading = true;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  // ===== ขอ permission + หาตำแหน่ง =====
  Future<void> _initLocation() async {
    final status = await Permission.location.request();

    if (!status.isGranted) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentPosition = LatLng(
        position.latitude,
        position.longitude,
      );

      // marker ตำแหน่งปัจจุบัน
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: _currentPosition,
          infoWindow: const InfoWindow(title: 'คุณอยู่ที่นี่'),
        ),
      );

      await _fetchLocations();

      // ขยับกล้องหลังจากได้ทุกอย่างแล้ว
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition, 15),
      );
    } catch (e) {
      debugPrint("Location error: $e");
    }

    setState(() => _isLoading = false);
  }

  // ===== ดึง marker จาก API =====
  Future<void> _fetchLocations() async {
    final url = Uri.parse(
      'https://hosting.udru.ac.th/~it67040233115/mobile/all_task.php',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      final apiMarkers = data.map<Marker>((item) {
        return Marker(
          markerId: MarkerId(item['id'].toString()),
          position: LatLng(
            double.parse(item['latitude'].toString()),
            double.parse(item['longitude'].toString()),
          ),
          infoWindow: InfoWindow(
            title: item['name'] ?? 'ไม่ระบุชื่อ',
          ),
        );
      }).toSet();

      setState(() {
        _markers.addAll(apiMarkers);
      });
    } else {
      debugPrint('Failed to load locations');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map Flutter'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}
