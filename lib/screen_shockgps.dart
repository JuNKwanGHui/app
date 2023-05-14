import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class ShockGps extends StatefulWidget {
  final String numberPrefix;
  ShockGps(this.numberPrefix);
  @override
  _ShockGpsState createState() => _ShockGpsState();
}

class _ShockGpsState extends State<ShockGps> {
  late GoogleMapController _controller;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("shock");

  late String shockTime_h;
  late String shockTime_m;
  late String shockTime_s;

  @override
  void initState() {
    super.initState();
    shockTime_h = widget.numberPrefix.split('_').last.substring(0, 2);
    shockTime_m = widget.numberPrefix.split('_').last.substring(2, 4);
    shockTime_s = widget.numberPrefix.split('_').last.substring(4, 6);
  }

  void _onMapCreated(GoogleMapController controller) {
    if (mounted) {
      setState(() {
        _controller = controller;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text(
        '$shockTime_h시 $shockTime_m분 $shockTime_s초',
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
      body: FutureBuilder<DataSnapshot>(
        future: databaseReference
            .orderByKey()
            .startAt(widget.numberPrefix)
            .endAt(widget.numberPrefix + "\uf8ff")
            .limitToLast(1)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.value != null) {
            final data = (snapshot.data!.value as Map<dynamic, dynamic>?)?.values.first;
            final lat = double.parse(data["lat"] ?? "37.211753");
            final lng = double.parse(data["lng"] ?? "126.952445");

            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                zoom: 16.0,
              ),
              markers: Set<Marker>.of([
                Marker(
                  markerId: MarkerId("current-location"),
                  position: LatLng(lat, lng),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                )
              ]),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
