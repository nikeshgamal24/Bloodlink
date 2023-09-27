import 'package:flutter/material.dart';

class AcceptorCard extends StatelessWidget {
  final String acceptorName;
  final String email;
  final int contactNumber;
  final String status;
  const AcceptorCard({
    super.key,
    required this.acceptorName,
    required this.contactNumber,
    required this.email,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
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
                          "Acceptors Details: ",
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
                    "Acceptor Name: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    acceptorName,
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
                    "Contact Number: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$contactNumber',
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
                    "Email: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                     email,
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
                    "Status: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                     status,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
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
