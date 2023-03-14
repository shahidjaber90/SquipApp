import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:squip/Utils/firebrigade_data.dart';

class FireBrigadeMapViewPage extends StatefulWidget {
  const FireBrigadeMapViewPage({super.key});

  @override
  State<FireBrigadeMapViewPage> createState() => _FireBrigadeMapViewPageState();
}

class _FireBrigadeMapViewPageState extends State<FireBrigadeMapViewPage> {
  final firestoreDB =
      FirebaseFirestore.instance.collection("hospitals").snapshots();
  TextEditingController add = TextEditingController();

  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.95898408522607, 67.0822085522736),
    zoom: 12,
  );

  List<Marker> _marker = [];
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(fireBrigadeList);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
