import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Utils/polica_data.dart';
import 'package:squip/services/get_help.dart';

class PoliceMapViewPage extends StatefulWidget {
  const PoliceMapViewPage({super.key});

  @override
  State<PoliceMapViewPage> createState() => _PoliceMapViewPageState();
}

class _PoliceMapViewPageState extends State<PoliceMapViewPage> {
  final firestoreDB =
      FirebaseFirestore.instance.collection("hospitals").snapshots();
  TextEditingController messageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
          markerId: MarkerId('111'),
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
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                markers: Set<Marker>.of(_marker),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstant.btnGreyColor,
              ),
              child: ElevatedButton(
                  onPressed: () {
                    getHelp(context, messageController, 'Message',
                        phoneController, 'Phone','police');
                             

                 },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.btnGreyColor,
                    elevation: 0,
                    maximumSize: const Size(350, 70),
                  ),
                  child: Text(
                    'Get Help',
                    style: GoogleFonts.ebGaramond(
                        color: ColorConstant.whiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  )),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstant.whiteColor,
          onPressed: () async {
            getUserCurrentLocation().then((value) async {
              _marker.add(Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: InfoWindow(title: '$address')));

              CameraPosition cameraPosition = CameraPosition(
                  zoom: 14, target: LatLng(value.latitude, value.longitude));

              final GoogleMapController controller = await _controller.future;

              controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));

              setState(() {});
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
