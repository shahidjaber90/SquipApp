
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Marker> fireBrigadeList = const [
  Marker(
    markerId: MarkerId('1'),
    position: LatLng(24.980476735015984, 67.06898474508085),
    infoWindow: InfoWindow(title: 'Fire Brigade', snippet: 'New Karachi Station,Karachi'),
  ),
  Marker(
    markerId: MarkerId('2'),
    position: LatLng(24.922852977398097, 67.03210146782011),
    infoWindow: InfoWindow(title: 'Fire Station', snippet: 'NAZIMABAD Fire Station,Karachi'),
  ),
  Marker(
    markerId: MarkerId('3'),
    position: LatLng(24.915180501680165, 67.09129580645047),
    infoWindow: InfoWindow(title: 'Fire Station', snippet: 'Gulshan-e-Iqbal Fire Station,Karachi'),
  ),
  Marker(
    markerId: MarkerId('4'),
    position: LatLng(24.894861901499105, 67.07670459003239),
    infoWindow: InfoWindow(
        title: 'Saifee Hospital', snippet: 'North Nazim Abad,Karachi'),
  ),
  Marker(
    markerId: MarkerId('5'),
    position: LatLng(24.92488727544984, 67.04549533922132),
    infoWindow: InfoWindow(title: 'Fire Station', snippet: 'AKUH Fire Station,Karachi'),
  ),
  Marker(
    markerId: MarkerId('6'),
    position: LatLng(24.922263977891657, 67.08769091768833),
    infoWindow: InfoWindow(title: 'Fire Station', snippet: 'Civic Center Fire Station,Karachi'),
  ),
];
