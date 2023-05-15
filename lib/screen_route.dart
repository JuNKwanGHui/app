import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {

  late GoogleMapController _controller;
  Set<Marker> _markers = {}; // Set to hold markers

  void _onMapCreated(GoogleMapController controller) {
    if (mounted) {
      setState(() {
        _controller = controller;
      });
    }
  }

  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference().child("gps");

  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text(
          '위치 찾기',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.211753, 126.952445),
              zoom: 16.0,
            ),
            markers: _markers,
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () => _showDateTimePicker(context),
              child: Icon(Icons.calendar_today),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDateTimePicker(BuildContext context) async {
    final initialDate = selectedDateTime;
    final newDateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (newDateTime != null) {
      final newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      if (newTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            newDateTime.year,
            newDateTime.month,
            newDateTime.day,
            newTime.hour,
            newTime.minute,
          );
        });
        // Fetch GPS data for the selected date and time from the database
        _fetchGPSData();
      }
    }
  }

  Future<void> _fetchGPSData() async {
    final dateFormat = DateFormat("yyyyMMdd");
    final timeFormat = DateFormat("HHmmss");
    final dateStr = dateFormat.format(selectedDateTime);
    final timeStr = timeFormat.format(selectedDateTime);
    final timestampStr = "$dateStr" + "_" + "$timeStr";

    final snapshot = await databaseReference.child(timestampStr).once();


    final gpsData = snapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (gpsData != null) {
      final lat = double.parse(gpsData["lat"] ?? "37.211753");
      final lng = double.parse(gpsData["lng"] ?? "126.952445");

      setState(() {
        _markers.clear(); // Clear previous markers
        _markers.add(
          Marker(
            markerId: MarkerId("selected-location"),
            position: LatLng(lat, lng),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      });

      _controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(lat, lng),
          16.0,
        ),
      );
    }
  }
}

