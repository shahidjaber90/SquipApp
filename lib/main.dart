import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squip/Provider/register_provider.dart';
import 'package:squip/Views/police_view.dart';
import 'package:squip/Views/send_notifications.dart';
import 'package:squip/Views/splash_logo.dart';
import 'package:squip/Views/splash_screen.dart';
import 'package:squip/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler (RemoteMessage message) async{
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RoleRegisterProvider(),
        ),
      ],
      child:const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  PoliceMapViewPage(),
      ),
    );
  }
}

