import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Utils/firebrigade_data.dart';
import 'package:squip/services/get_help.dart';

class FireBrigadeMapViewPage extends StatefulWidget {
  const FireBrigadeMapViewPage({super.key});

  @override
  State<FireBrigadeMapViewPage> createState() => _FireBrigadeMapViewPageState();
}

class _FireBrigadeMapViewPageState extends State<FireBrigadeMapViewPage> {
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
  final _formKey = GlobalKey<FormState>();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(fireBrigadeList);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
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
                          phoneController, 'Phone','fireBrigade',(value) {
                                if (value!.length < 16) {
                                  return "Please enter some message.";
                                }
                              },);
                               
    
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
        ),
      ),
    );
  }
}
