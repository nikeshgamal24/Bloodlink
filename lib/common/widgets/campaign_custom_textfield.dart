import 'package:flutter/material.dart';

class CampaignCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CampaignCustomTextField(
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
        if(value!.isEmpty){
          return  'This field is required';
        }
        switch (hintText) {
          case 'Enter Campaign Contact Email':
            //email validation
            // Check if this field is empty
            if (value.isEmpty) {
              return 'This field is required';
            }

            // using regular expression
            if (!RegExp("^[a-zA-Z0-9_.+-]+@(gmail.com|yahoo.com|hotmail.com)\$")
                .hasMatch(value)) {
              return "Please enter a valid email address";
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
            } else if (hintText == "Enter Campaign Date i.e. yy-mm-dd") {
              
              // Define a regular expression to match the "yyyy-mm-dd" format
              RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
              if (!dateRegExp.hasMatch(value)) {
                return "Enter correct format of date";
              }
              DateTime parsedDate = DateTime.parse(value);
              if (parsedDate.isBefore(DateTime.now())) {
                return "Invalid Date!!! Please Enter Future Date";
              }
            } else if (value is String &&
                hintText != "Campaign Status i.e. Either 'Every' or ' '") {
              //checks value is not empty
              if (value.isEmpty) {
                return "This Field is required";
              }

              //checks except time field all other fields are of more tha 5 characters and must start with alphabets
              if (hintText == "Enter Campaign Start Time i.e. 10AM" ||
                  hintText == "Enter Campaign End Time i.e. 1PM") {
                // Handle the time format cases
                if (value.length == 3 || value.length == 4) {
                  final firstTwoDigits = value.substring(0, 2);
                  final amOrPm =
                      value.substring(value.length - 2).toUpperCase();

                  if (int.tryParse(firstTwoDigits) is int &&
                      (amOrPm.toUpperCase() == "AM" || amOrPm == "PM") &&
                      int.parse(firstTwoDigits) >= 1 &&
                      int.parse(firstTwoDigits) <= 12) {
                    return null; // Valid time format
                  }
                }
              } else if (hintText == "Campaign Day i.e. Sunday") {
                if (value.toLowerCase() != "sunday" &&
                    value.toLowerCase() != "monday" &&
                    value.toLowerCase() != "tuesday" &&
                    value.toLowerCase() != "wednesday" &&
                    value.toLowerCase() != "thursday" &&
                    value.toLowerCase() != "friday" &&
                    value.toLowerCase() != "saturday") {
                  return "Invalid Input Day! Please enter valid day of the week";
                }
              } else {
                if (value.trim().length < 5) {
                  return 'Input cannot be less than 5 characters';
                }

                if (!RegExp(r"^[a-zA-Z][a-zA-Z0-9_ ]*$")
                    .hasMatch(value.trim())) {
                  return "Invalid Input. Must start with alphabet";
                }
              }
              return null;
            } else {
              if (hintText == "Campaign Status i.e. Either 'Every' or ' '") {
                if (value.isNotEmpty) {
                  if (value.toLowerCase() != 'every') {
                    return "Invalid field type";
                  }
                }
              }
            }
            break;
        }
        //if no error
        return null;
      },
    );
  }
}
