import 'package:flutter/material.dart';
import 'package:squip/Utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

buttonCategory(context, textButton, route){
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => route ));
    },
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
          BoxShadow(
            color: ColorConstant.greyColor,
            blurRadius: 10.0, 
            spreadRadius: 0.01,
          )
        ],
        ),
        child: Center(
          child: Text(textButton,style: GoogleFonts.ebGaramond(
            color: ColorConstant.darkGreyColor,
            fontSize: 24,
            fontWeight: FontWeight.w400,
            letterSpacing: 1
          ),
          ),
        ),
      ),
    ),
  );
}