import 'package:flutter/material.dart';
import 'package:squip/Utils/colors.dart';
// import 'package:squip/services/notifications_services.dart';

class SendNotificationsPage extends StatefulWidget {
  const SendNotificationsPage({super.key});

  @override
  State<SendNotificationsPage> createState() => _SendNotificationsPageState();
}

class _SendNotificationsPageState extends State<SendNotificationsPage> {
  // NotificationsServices notificationsServices = NotificationsServices();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        'Notifications'.toUpperCase(),
        style: TextStyle(color: ColorConstant.primaryColor, fontSize: 50),
      ),
    ));
  }
}
