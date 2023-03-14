import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:squip/Provider/register_provider.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Utils/images.dart';
import 'package:squip/Views/home_view.dart';
import 'package:squip/Views/user_login.dart';
import 'package:squip/widgets/submitButton_widget.dart';
import 'package:squip/widgets/textfield_widget.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    RoleRegisterProvider rProvider = RoleRegisterProvider();
    List typeUser = [
      rProvider.setUserType(UserType.police).toString(),
      rProvider.setUserType(UserType.ambulance).toString(),
      rProvider.setUserType(UserType.fireBrigade).toString(),
      rProvider.setUserType(UserType.user).toString(),
    ];

    emailValidator(value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

   pwdValidator(value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

    var _currentItemSelected = "user";
    var userType = "user";

    return Form(
      key: _formKey,
      child: SafeArea(child: Scaffold(
          body: Consumer<RoleRegisterProvider>(builder: (context, val, child) {
        return Center(
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
                  padding: const EdgeInsets.only(top: 6),
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
                        height: 6,
                      ),
                      Text(
                        'Create Account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.firaSansCondensed(
                            color: ColorConstant.darkGreyColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFieldWidget(
                          controllers: userNameController,
                          hintText: 'Username',
                          iconValue: const Icon(Icons.people_alt_outlined),
                          validator: (value) {
                            if (value.length < 3) {
                          return "Please enter a valid user name.";
                            }
                          },
                          inputType: TextInputType.emailAddress,obsecure: false),
                      TextFieldWidget(
                          controllers: emailController,
                          hintText: 'Email',
                          iconValue: const Icon(Icons.email),
                          validator: emailValidator,
                          inputType: TextInputType.emailAddress,obsecure: false),
                      TextFieldWidget(
                          controllers: passwordController,
                          hintText: 'Password',
                          iconValue: const Icon(Icons.lock),
                          validator: pwdValidator,
                          inputType: TextInputType.emailAddress,obsecure: true),
                      TextFieldWidget(
                          controllers: phoneController,
                          hintText: 'Phone',
                          iconValue: const Icon(Icons.contact_phone_outlined),
                          validator: (value) {
                            if (value.length < 11) {
                          return "Please enter a valid contact.";
                            }
                          },
                          inputType: TextInputType.number,obsecure: false),
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 34,right: 34),
                        child: DropdownButtonFormField<UserType>(
                          dropdownColor: ColorConstant.greyColor,
                          borderRadius: BorderRadius.circular(24),
                          value: val.userType,
                          items: 
                          [
                            DropdownMenuItem(
                              value: UserType.user,
                              child: Text(
                                'User',
                                style: GoogleFonts.ebGaramond(
                                    color: ColorConstant.darkGreyColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1),
                              ),
                            ),
                            DropdownMenuItem(
                              value: UserType.police,
                              child: Text(
                                'Police',
                                style: GoogleFonts.ebGaramond(
                                    color: ColorConstant.darkGreyColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1),
                              ),
                            ),
                            DropdownMenuItem(
                              value: UserType.ambulance,
                              child: Text(
                                'Ambulance',
                                style: GoogleFonts.ebGaramond(
                                    color: ColorConstant.darkGreyColor,
                                    fontSize:18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1),
                              ),
                            ),
                            DropdownMenuItem(
                              value: UserType.fireBrigade,
                              child: Text(
                                'FireBrigade',
                                style: GoogleFonts.ebGaramond(
                                    color: ColorConstant.darkGreyColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            val.setUserType(value!);
                          },
                          decoration: InputDecoration(
                            labelText: 'User Type',
                                labelStyle:  GoogleFonts.ebGaramond(
                                    color: ColorConstant.primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1),
                          ),
                        ),
                      ),
                      
                      SubmitButton(textButton: 'Sign Up', 
                      btnColor: ColorConstant.btnGreyColor, 
                      textColor: ColorConstant.whiteColor, 
                      onTap: ()async{

                        // RoleRegisterProvider().createUser(context, userNameController.text,
                        //  emailController.text, 
                        //  passwordController.text, 
                        //  phoneController.text, 
                        //  _formKey);


                        if (_formKey.currentState!.validate()) {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                        await  FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((currentUser) => FirebaseFirestore.instance
                                  .collection("users").doc(currentUser.user!.uid).set
                                  ({
                                    "user name": userNameController.text,
                                    "email": emailController.text,
                                    "password": passwordController.text,
                                    "phone": phoneController.text,
                                    "user type": rProvider.userType,
                                    "uid": currentUser.user!.uid,
                                  })
                                  .then((result) => {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => UserLoginView()),
                                            (_) => false),
                                        userNameController.clear(),
                                        emailController.clear(),
                                        passwordController.clear(),
                                        phoneController.clear(),
                                      })
                                  .catchError((err) => print('Error is kanjer:  ${err}')))
                              .catchError((err) => print('Error is kanjer:  ${err}'));
                        } 








                      }),

                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: GoogleFonts.ebGaramond(
                                  color: ColorConstant.btnGreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserLoginView()));
                                },
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.ebGaramond(
                                      color: ColorConstant.darkGreyColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //
          ),
        ));
      }))),
    );
  }
}
