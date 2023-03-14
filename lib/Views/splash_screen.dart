import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Utils/images.dart';
import 'package:squip/Views/user_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) =>  UserLoginView(),
      ));
    });
  }

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Lottie.asset(ImageConstant.policeSplash,width: 300,height: 220),
                        Lottie.asset(ImageConstant.ambulanceSplash,width: 300,height: 220,),
                        Lottie.asset(ImageConstant.fireSplash,width: 300,height: 220),
                      ],
                    ),
                ),
              ),
            ),
        ),
      ),
    );
  }
}
