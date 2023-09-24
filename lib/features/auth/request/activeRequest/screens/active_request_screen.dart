import 'package:flutter/material.dart';
import 'package:test/features/auth/request/activeRequest/services/request_services.dart';
import 'package:test/features/auth/request/activeRequest/widgets/blood_request_details.dart';
import 'package:test/models/blood_request.dart';

import '../../../../../constants/global_variables.dart';

class ActiveRequestScreen extends StatefulWidget {
  const ActiveRequestScreen({super.key});

  @override
  State<ActiveRequestScreen> createState() => _ActiveRequestScreenState();
}

class _ActiveRequestScreenState extends State<ActiveRequestScreen> {
  final RequestServices requestServices = RequestServices();
  List<BloodRequest> bloodRequestList = [];

  @override
  void initState() {
    super.initState();
    fetchAllRequests();
  }

  fetchAllRequests() async {
    bloodRequestList = await requestServices.fetchAllRequests(context);
    setState(() {
      // to re-build
    });
  }

  @override
  Widget build(BuildContext context) {
    String bloodGroup, location, patientName, caseOfRequest, hospitalName;
    int? phoneNumber;
    String? contact;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          //reason to use the flexiblespace is that we want to have the linear Gradient to the AppBar but AppBar doesnot have the property lineargradiend so we use flexibleSpace
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                    SizedBox(
                    child: Text(
                      "Blood Requests",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black,
                  size: 32,
                ),
              )
            ],
          ),
        ),
      ),
      // fetcht the data and poulate the screen
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: bloodRequestList.length,
          itemBuilder: ((context, index) {
            final bloodRequestData = bloodRequestList[index];

            //values for passing to the widget
            bloodGroup = bloodRequestData.recipientBloodGroup;
            location = bloodRequestData.streetName;
            patientName = bloodRequestData.recipientName;
            caseOfRequest = bloodRequestData.caseOfRequest;
            hospitalName = bloodRequestData.hospitalName;
            contact = bloodRequestData.contact;
            phoneNumber = bloodRequestData.phoneNumber;

            //return a colum for images and details of the product
            return Column(
              children: [
                BlooddRequestDetails(
                  bloodGroup: bloodGroup,
                  location: location,
                  patientName: patientName,
                  caseOfRequest: caseOfRequest,
                  hospitalName: hospitalName,
                  contact: contact,
                  phoneNumber: phoneNumber,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
