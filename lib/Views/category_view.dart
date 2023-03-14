import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Utils/images.dart';
import 'package:squip/Views/user_login.dart';
import 'package:squip/widgets/button_widget.dart';

class CategoryUsersView extends StatelessWidget {
  const CategoryUsersView({super.key});

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
                child: Padding(
                  padding: const EdgeInsets.only(top: 75),
                  child: Column(
                    children: [
                      Opacity(
                        opacity: 0.50,
                        child: Image.asset(
                          ImageConstant.logoSplash,
                          width: 220,
                          height: 100,
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Text(
                        'Are you User/Counsellor?',textAlign: TextAlign.center,
                        style: GoogleFonts.ebGaramond(
                            color: ColorConstant.darkGreyColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1),
                      ),
                      const SizedBox(
                        height: 72,
                      ),
                      buttonCategory(context, 'User',  UserLoginView()),
                      buttonCategory(
                          context, 'Counsellor',  UserLoginView()),
                    ],
                  ),
                ),
             
              ),
            ),
          ),
        ),
      ),
    );
  }
}
