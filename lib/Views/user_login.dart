import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Utils/images.dart';
import 'package:squip/Views/fireBrigade_view.dart';
import 'package:squip/Views/home_view.dart';
import 'package:squip/Views/hospital_view.dart';
import 'package:squip/Views/police_view.dart';
import 'package:squip/Views/signup_view.dart';
import 'package:squip/widgets/submitButton_widget.dart';

class UserLoginView extends StatefulWidget {
  UserLoginView({super.key});

  @override
  State<UserLoginView> createState() => _UserLoginViewState();
}

class _UserLoginViewState extends State<UserLoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
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
                            height: 24,
                          ),
                          Text(
                            'Login In',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSansCondensed(
                                color: ColorConstant.darkGreyColor,
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1),
                          ),
                          const SizedBox(
                            height: 36,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.80,
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
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    prefixIcon: const Icon(Icons.email),
                                    iconColor: ColorConstant.darkGreyColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width * 0.80,
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
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: ColorConstant.greyColor,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.78,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Text('Forget your Password?',
                                        style: GoogleFonts.ebGaramond(
                                            fontSize: 16,
                                            letterSpacing: 0.5,
                                            color: ColorConstant.btnGreyColor)))
                              ],
                            ),
                          ),
                          SubmitButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((currentUser) => FirebaseFirestore
                                            .instance
                                            .collection("users")
                                            .doc(currentUser.user!.uid)
                                            .get()
                                            .then((DocumentSnapshot result) {
                                          if (result.exists) {
                                            if (result.get('user type') == "Police") {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PoliceMapViewPage(),
                                                ),
                                              );
                                            } else  if (result.get('user type') == "ambulance") {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HospitalMapViewPage(),
                                                ),
                                              );
                                            } else  if (result.get('user type') == "fireBrigade") {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FireBrigadeMapViewPage(),
                                                ),
                                              );
                                            } else  if (result.get('user type') == "user") {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeViewPage(),
                                                ),
                                              );
                                            }
                                           
                                          }
                                        }).catchError((err) {
                                          
                                        print('Error yahan ata h bhai: '+err.toString());
                                        }
                                        
                                        ))
                                    .catchError((err) {
                                        print('Error yahan bhi ata h bhai: '+err.toString());
                                      
                                    }
                                    );
                              }
                            },
                            textButton: 'Sign In ',
                            btnColor: ColorConstant.btnGreyColor,
                            textColor: ColorConstant.whiteColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.78,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                        "Don't you have an account yet?",
                                        style: GoogleFonts.ebGaramond(
                                            fontSize: 16,
                                            letterSpacing: 0.5,
                                            color: ColorConstant.btnGreyColor)))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SubmitButton(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            },
                            textButton: 'Sign Up ',
                            btnColor: ColorConstant.btnGreyColor,
                            textColor: ColorConstant.whiteColor,
                          )
                        ],
                      ),
                    ),
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
