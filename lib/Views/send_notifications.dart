import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squip/Utils/colors.dart';
import 'package:http/http.dart' as http;

class SendNotificationsPage extends StatefulWidget {
  const SendNotificationsPage({super.key});

  @override
  State<SendNotificationsPage> createState() => _SendNotificationsPageState();
}

class _SendNotificationsPageState extends State<SendNotificationsPage> {
  String? mtoken = " ";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  TextEditingController uController = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    getToken();
    initInfo();
  }
  
  initInfo(){
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettins = InitializationSettings(android: androidInitialize,iOS: iOSInitialize);
    FlutterLocalNotificationsPlugin().initialize(initializationsSettins, onSelectNotification: (String? payload) async{
      try{
        if(payload != null && payload.isNotEmpty){

        }else{

        }
      }catch (e){

      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async { 
      print("...............onMessage...............");
      print("onMessage: ${message.notification?.title}/${message.notification?.body}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(), htmlFormatBigText: true,
        contentTitle:  message.notification!.title.toString(), htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'dbfood', 'dbfood', importance:  Importance.max,
        styleInformation:  bigTextStyleInformation, priority:  Priority.max, playSound: false,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,
      iOS: const IOSNotificationDetails()
      );
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title, 
      message.notification?.body, platformChannelSpecifics,
      payload: message.data['title']);
    });


  }


  void getToken() async {
   await FirebaseMessaging.instance.getToken().then(
           (token) {
          setState( () {
            mtoken = token;
            print("My token is ${mtoken}");
            });
             saveToken(token!);
            }
           );
        } 

  void saveToken(String token) async {
          await FirebaseFirestore.instance.collection("userTokens").doc("User2").set({
            'token' : token,
          });
        }

  void requestPermission()async{
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

    if (settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional){
      print('user granted provisional permission');
    } else{
      print('user declined or has not accepted permission');
    }
  }

void sendPushMessage(String token, String title, String body)async{
  try{
    await http.post( Uri.parse('https://fcm.google.apis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type' : 'applicatioin/json',
      'Authorization' : 'key=BAYOmvGrRfIH3kPF2Mv-yrLQwcROo5Xle3i8ySm5AcxTb15L3yclVOHkVVBtOdqeCZdje8W1V8EM3XOmDk7UELU',
    },
    body: jsonEncode(
      <String, dynamic>{
        'priority': 'high',
        'data': <String,dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': 'done',
          'body': body,
          'title': title,
        },
        "notification":<String, dynamic>{
          "title": title,
          "body": body,
          "android_channel_id": "dbfood"
        },
        "to": token,
      },
    ),
    );
  }catch (e){
    if (kDebugMode){
      print("error push notification");
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: uController,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: title,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: body,
              ),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: () async{
                  String name = uController.text.trim();
                  String titleText = title.text;
                  String bodyText = body.text;

                  if(name != ""){
                    DocumentSnapshot snap = 
                    await FirebaseFirestore.instance.collection("UserTokens").doc(name).get();

                    String token = snap['token'];
                    print(token);

                    sendPushMessage(token, titleText, bodyText);
                  }



                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 220,
                  decoration: BoxDecoration(
                    color: ColorConstant.primaryColor,
                    borderRadius: BorderRadius.circular(24)
                  ),
                  child: Text('Button',style: GoogleFonts.adamina(
                    color: ColorConstant.whiteColor,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 24
                  ),),
                ),
              )
            ],
          ),
        )
      )),
    );
  }
}
