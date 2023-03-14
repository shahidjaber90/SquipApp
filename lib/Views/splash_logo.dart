import 'dart:async';

import 'package:flutter/material.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Utils/images.dart';
import 'package:squip/Views/splash_screen.dart';

class SplashLogo extends StatefulWidget {
  const SplashLogo({super.key});

  @override
  State<SplashLogo> createState() => _SplashLogoState();
}

class _SplashLogoState extends State<SplashLogo> {



  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const SplashScreen(),
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
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.90,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                    color: ColorConstant.whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageConstant.iconSplash),
                          Image.asset(ImageConstant.logoSplash),
                        ],
                      ),
                    )),
                ],
              ),
            ),
          ),
        ),
      ) );
  }
}