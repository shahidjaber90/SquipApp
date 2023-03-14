import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Utils/polica_data.dart';

class PoliceMapViewPage extends StatefulWidget {
  const PoliceMapViewPage({super.key});

  @override
  State<PoliceMapViewPage> createState() => _PoliceMapViewPageState();
}

class _PoliceMapViewPageState extends State<PoliceMapViewPage> {
  final firestoreDB =
      FirebaseFirestore.instance.collection("hospitals").snapshots();
  TextEditingController add = TextEditingController();

  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.95898408522607, 67.0822085522736),
    zoom: 12,
  );

  List<Marker> _marker = [];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error is : $error");
    });

    return await Geolocator.getCurrentPosition();
  }

  loadData() async {
    getUserCurrentLocation().then((value) async {
      _marker.add(Marker(
          markerId: MarkerId('1'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'My Current Location')));

      CameraPosition cameraPosition = CameraPosition(
          zoom: 14, target: LatLng(value.latitude, value.longitude));

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(policeList);
    loadData();
  }
  String? address;

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstant.whiteColor,
          onPressed: () async {
            getUserCurrentLocation().then((value) async {
              _marker.add(Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow:  InfoWindow(title: '$address')));

              CameraPosition cameraPosition = CameraPosition(
                  zoom: 14, target: LatLng(value.latitude, value.longitude));

              final GoogleMapController controller = await _controller.future;

              controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));

              setState(() {
              });
            });
          },
          child: Icon(
            Icons.my_location,
            color: ColorConstant.primaryColor,
            size: 28,
          ),
        ),
      ),
    );
  }
}
