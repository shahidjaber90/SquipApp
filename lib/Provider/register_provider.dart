import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Views/user_login.dart';
import 'package:squip/main.dart';

enum UserType {
  user,
  ambulance,
  police,
  fireBrigade,
}

class RoleRegisterProvider with ChangeNotifier {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController contact = TextEditingController();

  // final FirebaseAuth auth = FirebaseAuth.instance;

  UserType  _userType = UserType.user;

  UserType get userType => _userType;


  setUserType(UserType usertype) {
    _userType = usertype;
    notifyListeners();
  }

  void createUser(context, userName, email, password, phone, formkey) async {
    if (formkey.currentState.validated()) {

      final FirebaseAuth auth = FirebaseAuth.instance;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((currentUser) => FirebaseFirestore.instance
              .collection("users")
              .doc(currentUser.user!.uid)
              .set({
                "user name": userName.text,
                "email": email.text,
                "password": password.text,
                "phone": phone.text,
                "user type": userType.name,
                "uid": currentUser.user!.uid,
              })
              .then((result) => {
                
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserLoginView()),
                        (_) => false),
                    userName.clear(),
                    email.clear(),
                    password.clear(),
                    phone.clear(),
                  })
              .catchError((err) => print('Error is kanjer:  ${err}')))
          .catchError((err) => print('Error is kanjer:  ${err}'));
      notifyListeners();
    }

    //  createUser(context,) async {
    //   final CollectionReference users =
    //       FirebaseFirestore.instance.collection('users');
    //       final User? user = await _auth.currentUser;
    //       String uid = user!.uid.toString();
    //    users.add({
    //     'username': username.text,
    //     'email': email.text,
    //     'password': password.text,
    //     'usertype': _userType.name,
    //     'contact': contact.text,
    //     'uid':uid.toString()
    //    });
    //   try {
    //     UserCredential userCredential = await FirebaseAuth.instance
    //         .createUserWithEmailAndPassword(
    //             email: email.text, password: password.text);
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => UserLoginView()));
    //     email.clear();
    //     username.clear();
    //     password.clear();
    //     contact.clear();
    //     notifyListeners();
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'weak-password') {
    //       print('The password provided is too weak.');
    //       return Fluttertoast.showToast(
    //           msg: e.toString(),
    //           toastLength: Toast.LENGTH_SHORT,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: ColorConstant.primaryColor,
    //           textColor: ColorConstant.whiteColor,
    //           fontSize: 18.0);
    //     } else if (e.code == 'email-already-in-use') {
    //       print('The account already exists for that email.');
    //       return Fluttertoast.showToast(
    //           msg: e.toString(),
    //           toastLength: Toast.LENGTH_SHORT,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: ColorConstant.primaryColor,
    //           textColor: ColorConstant.whiteColor,
    //           fontSize: 18.0);
    //     }
    //   } catch (e) {
    //     print('e Message is =>>>>>>>>: ' + e.toString());
    //     return Fluttertoast.showToast(
    //         msg: e.toString(),
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: ColorConstant.primaryColor,
    //         textColor: ColorConstant.whiteColor,
    //         fontSize: 18.0);
    //   }

    notifyListeners();
  }
}
