import 'package:flutter/material.dart';
import 'package:squip/Utils/colors.dart';

class TextFieldWidget extends StatelessWidget {
   TextFieldWidget(
      {super.key,
      required this.controllers,
      required this.hintText,
      required this.iconValue,
      required this.validator,
      required this.inputType,
      required this.obsecure});

  TextEditingController controllers;
  final String hintText;
  final Icon iconValue;
  final validator;
  final inputType;
  final obsecure;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            obscureText: obsecure,
            validator: validator,
            controller: controllers,
            keyboardType: inputType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              prefixIcon: iconValue,
              iconColor: ColorConstant.darkGreyColor,
            ),
          ),
        ),
      ),
    );
  }
}
