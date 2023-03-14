
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Marker> hospitalsList = const [
  Marker(
    markerId: MarkerId('1'),
    position: LatLng(24.93882548258219, 67.07749175456303),
    infoWindow:
        InfoWindow(title: 'Mamji Hospital', snippet: 'Water Pump,Karachi'),
  ),
  Marker(
    markerId: MarkerId('2'),
    position: LatLng(24.938190196715446, 67.06615136347887),
    infoWindow: InfoWindow(
        title: 'Rafah-E-Aam Hospital', snippet: 'Gulberg 13,Karachi'),
  ),
  Marker(
    markerId: MarkerId('3'),
    position: LatLng(24.943749701840854, 67.04719329689237),
    infoWindow:
        InfoWindow(title: 'Imam Clinic', snippet: 'North Nazim Abad,Karachi'),
  ),
  Marker(
    markerId: MarkerId('4'),
    position: LatLng(24.931511781219413, 67.03850471038609),
    infoWindow: InfoWindow(
        title: 'Saifee Hospital', snippet: 'North Nazim Abad,Karachi'),
  ),
  Marker(
    markerId: MarkerId('5'),
    position: LatLng(24.92488727544984, 67.04549533922132),
    infoWindow: InfoWindow(
        title: 'Ziauddin Hospital', snippet: 'North Nazim Abad,Karachi'),
  ),
  Marker(
    markerId: MarkerId('6'),
    position: LatLng(24.919052364908776, 67.063642583398),
    infoWindow: InfoWindow(title: 'Tabba Heart', snippet: 'Aziz Abad,Karachi'),
  ),
];
