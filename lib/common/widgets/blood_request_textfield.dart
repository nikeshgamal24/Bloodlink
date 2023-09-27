import 'package:flutter/material.dart';

class BloodRequestCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const BloodRequestCustomTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // obscureText: (hintText.toLowerCase() == "password") ||(hintText.toLowerCase() == "confirm password") ? true : false,
      controller: controller,
      // initialValue: controller.text,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 84, 88, 92),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          floatingLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 41, 42, 44),
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          filled: true,
          labelText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
      style: const TextStyle(
        fontSize: 15,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        switch (hintText) {
          case 'Recipient Name':
            if (value.trim().length < 5) {
              return 'Input cannot be less than 5 characters';
            }

            if (!RegExp(r"^[a-zA-Z][a-zA-Z0-9_ ]*$").hasMatch(value.trim())) {
              return "Invalid Input. Must start with alphabet";
            }
            return null;
          case 'Recipient Blood Group':
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
          case 'Required Pints':
            if (int.parse(value) <= 0) {
              return "Please enter a input! Required Pints can't be negative or zero";
            }
            return null;
          case 'Enter Postal Code':
            if (int.parse(value) <= 0) {
              return "Please enter a input!Postal Code can't be negative or zero";
            }
            return null;
          case "Enter Required Date i.e. yyyy-mm-dd":
            // Define a regular expression to match the "yyyy-mm-dd" format
            RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
            if (!dateRegExp.hasMatch(value)) {
              return "Enter correct format of date";
            }
            DateTime parsedDate = DateTime.parse(value);
            if (parsedDate.isBefore(DateTime.now())) {
              return "Invalid Date!!! Please Enter Future Date";
            }
            return null;
          case "Enter Case of request":
            if (value.trim().length < 5) {
              return 'Input cannot be less than 5 characters';
            }

            if (!RegExp(r"^[a-zA-Z][a-zA-Z0-9_ ]*$").hasMatch(value.trim())) {
              return "Invalid Input. Must start with alphabet";
            }
            return null;
          default:
            if (hintText == "Enter Postal Code" ||
                hintText == "Enter Ward Number" ||
                hintText == "Enter Goal of Pint Number" ||
                hintText == "Enter Campaign Contact Number") {
              if (int.parse(value) <= 0) {
                return "Invalid Input! Shouldn't contain negative or zero number";
              }
              //checking for valid ward number in the function create\
            }
        }
        //if no error
        return null;
      }
    );
  }
}
