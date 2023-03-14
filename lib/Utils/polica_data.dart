
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Marker> policeList = const [
  Marker(
    markerId: MarkerId('1'),
    position: LatLng(24.917187618551246, 67.06308216035175),
    infoWindow: InfoWindow(title: 'Azizabad Police Station', snippet: 'Azizabad Police Station,Karachi'),
  ),
  Marker(
    markerId: MarkerId('2'),
    position: LatLng(24.91377998629223, 67.05388152958342),
    infoWindow: InfoWindow(title: 'Shareefabad Police Station', snippet: 'Shareefabad Police Station,Karachi'),
  ),
  Marker(
    markerId: MarkerId('3'),
    position: LatLng(24.930686159479823, 67.07324620795445),
    infoWindow: InfoWindow(title: 'Yousuf Plaza Police Station', snippet: 'Yousuf Plaza Police Station,Karachi'),
  ),
  Marker(
    markerId: MarkerId('4'),
    position: LatLng(24.9365606532834, 67.06695966342821),
    infoWindow: InfoWindow(
        title: 'Gulberg Police Station', snippet: 'Gulberg Police Station,Karachi'),
  ),
  Marker(
    markerId: MarkerId('5'),
    position: LatLng(24.940882913432564, 67.08751605053232),
    infoWindow: InfoWindow(title: 'FB Industrial Area', snippet: 'Industrial Area Police Station,Karachi'),
  ),
  Marker(
    markerId: MarkerId('6'),
    position: LatLng(24.94407375471863, 67.03430102594882),
    infoWindow: InfoWindow(title: 'Shahrah Noor Jahan Police Station', snippet: 'Shahrah Noor Jahan Police Station,Karachi'),
  ),
];

Future<Position> getUserCurrentLocation() async {
  await Geolocator.requestPermission().then((value) {

  }).onError((error, stackTrace) {
    // print("Error is : $error");
  });

  return await Geolocator.getCurrentPosition();
}

loadData(marker, _controller)async{
  getUserCurrentLocation().then((value) async {
    marker.add(
      Marker(
        markerId: const MarkerId('111'),
        position: LatLng(value.latitude, value.longitude),
        infoWindow:const InfoWindow(
          title: 'My Current Location'
        )
         )
    );

    CameraPosition cameraPosition = CameraPosition(
      zoom: 14,
      target:LatLng(value.latitude, value.longitude));

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));     

  });
}
