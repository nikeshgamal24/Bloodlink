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
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        switch (hintText) {
          case 'Your email address':
            // using regular expression
            if (!RegExp("^[a-zA-Z0-9_.+-]+@(gmail.com|yahoo.com|hotmail.com|ncit.edu.np)\$")
                .hasMatch(value)) {
              return "Please enter a valid email address";
            }
            return null;
          case 'Your password':
            if (value.length < 8) {
              return 'Password cannot be less than 8 characters';
            }
          //return error message
          case 'Your full name':
            if (value.length < 5) {
              return 'Password cannot be less than 5 characters';
            }

            if (!RegExp(r"^[a-zA-Z][a-zA-Z0-9_ ]*$").hasMatch(value)) {
              return "Invalid Input. Must start with alphabet";
            }

            return null;
          case 'Your age':
            if (int.parse(value) <= 0) {
              return 'Age cannot be in negative';
            }

            if (!RegExp(r"^[1-9][0-9]*$").hasMatch(value)) {
              return "Invalid Age. Must start with Number";
            }

            return null;
          case 'Your sex i.e. Male or Female':
            if (value.toLowerCase() != 'male' &&
                value.toLowerCase() != 'female') {
              return 'Please,enter valid input';
            }

            return null;
          case "Your Phone Number":
            if (!RegExp(r"^98\d{8}$").hasMatch(value)) {
              return "Invalid Input! Enter 10 digit number 98...";
            }
            return null;
          case "Your Blood Group":
            List<String> validBloodGroups = [
              'A+',
              'A-',
              'B+',
              'B-',
              'AB+',
              'AB-',
              'O+',
              'O-'
            ];

            if (!validBloodGroups.contains(value.toUpperCase())) {
              return 'Please enter a valid blood group';
            }
            return null;
          case "Last Blood Donated Date i.e. yyyy-mm-dd":
            RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
              if (!dateRegExp.hasMatch(value)) {
                return "Enter correct format of date";
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
