import 'package:flutter/material.dart';

class RequestDetailedSection extends StatelessWidget {
  final String patientName;
  final String bloodGroup;
  final int requiredPintCount;
  final int pintCollectedCount;
  final String streetName;
  final String hospitalName;
  final String city;
  final String bloodRequiredDate;
  final String caseOfRequest;
  // final String contact;
  // final String phoneNumber;

  const RequestDetailedSection({
    super.key,
    required this.patientName,
    required this.bloodGroup,
    required this.requiredPintCount,
    required this.pintCollectedCount,
    required this.hospitalName,
    required this.streetName,
    required this.city,
    required this.bloodRequiredDate,
    required this.caseOfRequest,
    // required this.contact,
    // required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 338,
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
          const Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                         Text(
                          "Blood Request Details: ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 117, 23, 17),
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
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
                    "Blood Group: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    bloodGroup,
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
                    "Required Number of pints: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$requiredPintCount',
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
                    "Pints Collected: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$pintCollectedCount',
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
                    "Hospital Name: ",
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
                    "Blood Required Before: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    bloodRequiredDate,
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
                    "Case Of request: ",
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
                      streetName,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width:5,),
                  SizedBox(
                    child: Text(
                      ', $city',
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
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
