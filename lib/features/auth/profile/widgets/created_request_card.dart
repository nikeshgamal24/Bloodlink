// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:test/constants/global_variables.dart';

class CreatedRequestCard extends StatelessWidget {
  final String bloodGroup;
  final String location;
  final String patientName;
  final String caseOfRequest;
  final String hospitalName;
  final String? contact;
  final int? phoneNumber;
  const CreatedRequestCard({
    super.key,
    required this.bloodGroup,
    required this.location,
    required this.patientName,
    required this.caseOfRequest,
    required this.hospitalName,
    required this.contact,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 328,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black12,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(1.0, 1.0),
              spreadRadius: 1.0,
              blurRadius: 5,
            ),
            const BoxShadow(
              color: Color.fromARGB(255, 247, 245, 245),
              offset: Offset(-1.0, -1.0),
              spreadRadius: 1.0,
              blurRadius: 5,
            ),
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        const Text(
                          "Required Blood: ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 117, 23, 17),
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          bloodGroup,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 207, 45, 34),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 2,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
            child: SizedBox(
              child: Row(
                children: [
                  const Text(
                    "Patient Name: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    patientName,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
            child: SizedBox(
              child: Row(
                children: [
                  const Text(
                    "Hospital: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    hospitalName,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
            child: SizedBox(
              child: Row(
                children: [
                  const Text(
                    "Case: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    caseOfRequest,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
            child: SizedBox(
              child: Row(
                children: [
                  const Text(
                    "Contact: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    contact!,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
            child: SizedBox(
              child: Row(
                children: [
                  const Text(
                    "Phone: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    phoneNumber!.toString(),
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 2,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              child: Row(
                children: [
                  const SizedBox(
                    child: Icon(
                      Icons.pin_drop,
                      size: 25,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      location,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),Container(
            height: 2,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 8),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        GlobalVariables.loginSignUpButtonBackgroundColor,
                  ),
                  onPressed: (){},
                  child: Container(
                    width:60,
                    height: 40,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        GlobalVariables.loginSignUpButtonBackgroundColor,
                  ),
                  onPressed: (){},
                  child: Container(
                    width:60,
                    height: 40,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
