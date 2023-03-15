
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squip/Utils/colors.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:squip/Views/home_view.dart';

getHelp(context,namecontrol,controllers,hintText,emergency,phonetext,counsellor,validate,onTap){
  return showDialog(
    context: context,
    builder: (BuildContext  context) {
      return AlertDialog(
        backgroundColor: ColorConstant.greyColor,
        title: Text('Message: ',style: GoogleFonts.ebGaramond(
            color: ColorConstant.darkGreyColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            letterSpacing: 1
          ),),
          content: Container(
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
                            controller: emergency,
                            validator: validate,
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
                            controller: namecontrol,
                            validator: validate,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: ColorConstant.greyColor,
                              border: InputBorder.none,
                              hintText: phonetext,
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
                            controller: controllers,
                            validator: validate,
                            maxLines: 5,
                            minLines: 2,
                            decoration: InputDecoration(
                              fillColor: ColorConstant.greyColor,
                              border: InputBorder.none,
                              hintText: hintText,
                            ),
                          ),
                        ),
                        
                      
                  ),
                ),
              
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: onTap,
                  // (){

          //           if (controllers.text.isNotEmpty &&
          //       phone.text.isNotEmpty) {
          //     FirebaseFirestore.instance
          //       .collection(counsellor)
          //       .add({
          //         "message": controllers.text,
          //         "phone": phone.text
          //     });
          //       controllers.clear();
          //       phone.clear();
          //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeViewPage()))
          //     .then((result) => {
          //     })
          //     .catchError((err) => print(err));
          // }



          //           Navigator.pop(context);
                    // },
                   child: Text('Send',style: GoogleFonts.ebGaramond(
            color: ColorConstant.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 1
          ))
          )
                ],
              )
              ],
            ),
          ),
          
      
      );
    },
  );
}