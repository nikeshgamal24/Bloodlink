import 'package:flutter/material.dart';
// import 'package:email_validator/email_validator.dart';

class OTPCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const OTPCustomTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // obscureText: (hintText.toLowerCase() == "password") ||(hintText.toLowerCase() == "confirm password") ? true : false,
      controller: controller,
      decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 64, 67, 70),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          floatingLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 41, 42, 44),
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
          filled: true,
          labelText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      style: const TextStyle(
        fontSize: 15,
      ),
      validator: (value) {
       if(value ==null){
        return "This field is required!";
       }

       if(!(value.length==4)){
        return "Please! Enter four digit valid OTP code";
       }
       if(!RegExp(r'^\d{4}$').hasMatch(value)){
        return "Please, enter valid OTP code";
       }
        //if no error
        return null;
      },
    );
  }
}
