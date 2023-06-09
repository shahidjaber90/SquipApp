import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Utils/firebrigade_data.dart';
import 'package:squip/services/get_help.dart';
import 'package:http/http.dart' as http;

class FireBrigadeMapViewPage extends StatefulWidget {
  const FireBrigadeMapViewPage({super.key});

  @override
  State<FireBrigadeMapViewPage> createState() => _FireBrigadeMapViewPageState();
}

class _FireBrigadeMapViewPageState extends State<FireBrigadeMapViewPage> {
  
  String? mtoken = " ";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final firestoreDB =
      FirebaseFirestore.instance.collection("hospitals").snapshots();
  TextEditingController emergencyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Completer<GoogleMapController> _controller = Completer();
  final _formKey = GlobalKey<FormState>();

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

  

  String? address;
  @override
  void initState() {
    // TODO: implement initState
    _marker.addAll(fireBrigadeList);
    super.initState();
    requestPermission();
    getToken();
    initInfo();
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettins =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    FlutterLocalNotificationsPlugin().initialize(initializationsSettins,
        onSelectNotification: (String? payload) async {
      try {
        if (payload != null && payload.isNotEmpty) {
        } else {}
      } catch (e) {}
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("...............onMessage...............");
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'dbfood',
        'dbfood',
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.max,
        playSound: false,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: const IOSNotificationDetails());
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['title']);
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("My token is ${mtoken}");
      });
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance.collection("emergency").doc("Shahid Jaber").set({
      'token': token,
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisional permission');
    } else {
      print('user declined or has not accepted permission');
    }
  }

  void sendPushMessage(String token, String title, String body) async {
    try {
      await http.post(
        Uri.parse('https://fcm.google.apis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'applicatioin/json',
          'Authorization':
              'key=BAYOmvGrRfIH3kPF2Mv-yrLQwcROo5Xle3i8ySm5AcxTb15L3yclVOHkVVBtOdqeCZdje8W1V8EM3XOmDk7UELU',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "dbfood"
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
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
                      getHelp(context,nameController, messageController, 'Message',
                          emergencyController, 'Phone', 'police');
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
      ),
    );
  }
}
