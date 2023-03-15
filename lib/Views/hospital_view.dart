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
import 'package:squip/Utils/hospitals_data.dart';
import 'package:squip/services/get_help.dart';
import 'package:http/http.dart' as http;

class HospitalMapViewPage extends StatefulWidget {
  const HospitalMapViewPage({super.key});

  @override
  State<HospitalMapViewPage> createState() => _HospitalMapViewPageState();
}

class _HospitalMapViewPageState extends State<HospitalMapViewPage> {
  String? mtoken = " ";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final firestoreDB =
      FirebaseFirestore.instance.collection("hospitals").snapshots();
  TextEditingController emergencyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController = TextEditingController();

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

  final _formKey = GlobalKey<FormState>();

  String? address;
  @override
  void initState() {
    // TODO: implement initState
    _marker.addAll(hospitalsList);
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


                      showDialog(
                        context: context,
                        builder: (context) {
                          return  AlertDialog(
                              backgroundColor: ColorConstant.greyColor,
                              title: Text('Message: ',style: GoogleFonts.ebGaramond(
                                  color: ColorConstant.darkGreyColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1
                                ),),
                                content: SingleChildScrollView(
                                  child: Container(
                                    height: 320,
                                    width: MediaQuery.of(context).size.width * 0.96,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorConstant.greyColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstant.greyColor,
                                          blurRadius: 10.0,
                                          spreadRadius: 0.01,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        
                                        Container(
                                           height: 50,
                                    width: MediaQuery.of(context).size.width * 1.00,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorConstant.whiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstant.greyColor,
                                          blurRadius: 10.0,
                                          spreadRadius: 0.01,
                                        )
                                      ],
                                    ),
                                          child: Center(
                        child: 
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: emergencyController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  fillColor: ColorConstant.greyColor,
                                  border: InputBorder.none,
                                  hintText: 'Emergency',
                                ),
                              ),
                            ),
                            
                          
                                          ),
                                        ),
                                
                                          const SizedBox(height: 10,),
                                        Container(
                                           height: 50,
                                    width: MediaQuery.of(context).size.width * 1.00,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorConstant.whiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstant.greyColor,
                                          blurRadius: 10.0,
                                          spreadRadius: 0.01,
                                        )
                                      ],
                                    ),
                                          child: Center(
                        child: 
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: nameController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  fillColor: ColorConstant.greyColor,
                                  border: InputBorder.none,
                                  hintText: 'Shahid Jaber',
                                ),
                              ),
                            ),
                            
                          
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Container(
                                           height: 150,
                                    width: MediaQuery.of(context).size.width * 1.00,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorConstant.whiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstant.greyColor,
                                          blurRadius: 10.0,
                                          spreadRadius: 0.01,
                                        )
                                      ],
                                    ),
                                          child: Center(
                        child: 
                            Padding(
                              padding: const EdgeInsets.only(left:10),
                              child: TextFormField(
                                controller: messageController,
                                maxLines: 5,
                                minLines: 2,
                                decoration: InputDecoration(
                                  fillColor: ColorConstant.greyColor,
                                  border: InputBorder.none,
                                  hintText: 'Type your message here.......',
                                ),
                              ),
                            ),
                            
                          
                                          ),
                                        ),
                                      
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(onPressed: () async {
                          String name = emergencyController.text.trim();
                          String titleText = nameController.text;
                          String bodyText = messageController.text;
                      
                          if (name != "") {
                            DocumentSnapshot snap = await FirebaseFirestore
                                .instance
                                .collection("UserTokens")
                                .doc(name)
                                .get();
                      
                            String token = snap['token'];
                            print(token);
                      
                            sendPushMessage(token, titleText, bodyText);
                          }
                                          
                      
                                          
                                          },
                                           child: Text('Send',style: GoogleFonts.ebGaramond(
                                    color: ColorConstant.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1
                                  )
                                  )
                                  )
                                        ],
                                      )
                                      ],
                                    ),
                                  ),
                                ),
                                
                            
                            );
                        }
                      );
                     


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
