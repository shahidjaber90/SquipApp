import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squip/Utils/colors.dart';
import 'package:squip/Views/hospital_view.dart';

class EmergencyCardWidget extends StatelessWidget {
  String images;
  String title;
  Widget navigate;
  EmergencyCardWidget({super.key, required this.images,required this.title,required this.navigate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => navigate));
        },
        child: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: ColorConstant.primaryColor,
              boxShadow: [
            BoxShadow(
              color: ColorConstant.darkGreyColor,
              blurRadius: 15.0, 
              spreadRadius: 0.01,
            )
          ],
              ),
          child: Column(
            children: [
              Container(
                height: 160,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    color: ColorConstant.whiteColor,
                    image: DecorationImage(image: AssetImage(images),fit: BoxFit.fill)),
              ),
              Container(
                height: 40,
                width: 300,
                decoration:const BoxDecoration(
                    borderRadius:  BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ask Help to $title',style: GoogleFonts.ebGaramond(
              color: ColorConstant.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 1
            ),)
                      ],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
