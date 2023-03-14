import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Utils/images.dart';
import 'package:squip/Views/fireBrigade_view.dart';
import 'package:squip/Views/hospital_view.dart';
import 'package:squip/Views/police_view.dart';
import 'package:squip/widgets/emergencyCard_widget.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: ColorConstant.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.90,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  color: ColorConstant.whiteColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EmergencyCardWidget(images:ImageConstant.police, title: 'Police Emergency',navigate: const PoliceMapViewPage()),
                      EmergencyCardWidget(images:ImageConstant.ambulance, title: 'Medical Emergency',navigate:const HospitalMapViewPage()),
                      EmergencyCardWidget(images:ImageConstant.fireBrigade, title: 'Fire Brigade',navigate: const FireBrigadeMapViewPage()),
                    ],
                  ),
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}