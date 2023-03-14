import 'package:flutter/material.dart';
import 'package:squip/Utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

// submitButton(context, textButton,btnColor,textColor, route){
  class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.textButton,required this.btnColor,required this.textColor, required this.onTap });

  final String textButton;
  final Color btnColor;
  final Color textColor;
  final onTap ;


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          maximumSize: Size(350, 60),
          shadowColor: ColorConstant.darkGreyColor,
          shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
        ),
        child: Center(
          child: Text(textButton,style: GoogleFonts.ebGaramond(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w400,
            letterSpacing: 1
          ),
          ),
        ),
      ),
  );
  }
}
 