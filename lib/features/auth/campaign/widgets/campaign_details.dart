import 'package:flutter/material.dart';

class CampaignDetails extends StatelessWidget {
  final String campaignTitle;
  final String campaignDays;
  final String campaignDayStatus;
  final String campaignStartTime;
  final String campaignEndTime;
  final String campaignEndDate;
  final String streetName;
  final int goalPint;
  final int collectedPint;
  final String campaignOrganizer;
  final String campaignEmail;
  final int campaignContact;

  const CampaignDetails({
    super.key,
    required this.campaignTitle,
    required this.campaignDays,
    required this.campaignDayStatus,
    required this.campaignStartTime,
    required this.campaignEndTime,
    required this.campaignEndDate,
    required this.streetName,
    required this.goalPint,
    required this.collectedPint,
    required this.campaignOrganizer,
    required this.campaignEmail,
    required this.campaignContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
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
                        Text(
                          campaignTitle,
                          style: const TextStyle(
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
                    "Campaign Day: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        campaignDayStatus,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Text(
                        campaignDays,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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
                    "Campaign Time: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    campaignStartTime,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  const Text(
                    "to",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    campaignEndTime,
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
                    "Organizer: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    campaignOrganizer,
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
                    "Goal Pint: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    goalPint.toString(),
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
                    "Collected Pint: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    collectedPint.toString(),
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
                    campaignEmail.toString(),
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
                    campaignContact.toString(),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
