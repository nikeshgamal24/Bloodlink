import 'package:flutter/material.dart';
// import 'package:email_validator/email_validator.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // obscureText: (hintText.toLowerCase() == "password") ||(hintText.toLowerCase() == "confirm password") ? true : false,
      controller: controller,
      decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 84, 88, 92),
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
        switch (hintText.toLowerCase()) {
          case 'email':
            //email validation
            // Check if this field is empty
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }

            // using regular expression
            if (!RegExp("^[a-zA-Z0-9_.+-]+@(gmail.com|yahoo.com|hotmail.com)\$")
                .hasMatch(value)) {
              return "Please enter a valid email address";
            }
            return null;
          case 'password':
            //password validation
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }

            if (value.length < 8) {
              return 'Password cannot be less than 8 characters';
            }
          //return error message
          case 'username':
            //email validation
            // Check if this field is empty
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }

            if (value.length < 5) {
              return 'Password cannot be less than 5 characters';
            }

            if (!RegExp("^[a-zA-Z][a-zA-Z0-9_]*\$").hasMatch(value)) {
              return "Invalid username. Must start with alphabet";
            }

            return null;
          default:
            break;
        }
        //if no error
        return null;
      },
    );
  }
}
