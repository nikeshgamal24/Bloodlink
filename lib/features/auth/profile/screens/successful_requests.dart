import 'package:flutter/material.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/features/auth/profile/services/my_created_requests_service.dart';
import 'package:test/features/auth/request/activeRequest/widgets/blood_request_details.dart';
import 'package:test/models/blood_request.dart';

class SuccessfulRequestScreen extends StatefulWidget {
  static const String routeName = '/successful-requests';
  const SuccessfulRequestScreen({super.key});

  @override
  State<SuccessfulRequestScreen> createState() => _SuccessfulRequestScreen();
}

class _SuccessfulRequestScreen extends State<SuccessfulRequestScreen> {
  final MyCreatedRequestService myCreatedRequestService =
      MyCreatedRequestService();
  List<BloodRequest>? successfulRequests;

@override
void initState(){
  super.initState();
  fetchSuccessfulRequests();
}

fetchSuccessfulRequests() async {
    successfulRequests =
        await myCreatedRequestService.successfulRequests(context);
        setState(() {
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
              Container(
                // color: Colors.transparent,
                // height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: const Text(
                  'Sucessful Requests',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                  ),
                ),
              ),
              Container(
                // color: Colors.transparent,
                // height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
      body: successfulRequests == null
          ? const Loader()
          : successfulRequests!.isEmpty
              ? const Center(
                  child: Text(
                    "You don't have any successful requests yet!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: GlobalVariables.pageTitleColor,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                    itemCount: successfulRequests!.length, // The total number of items in the list
                    itemBuilder: (BuildContext context, int index) {
 final successfulRequestsData = successfulRequests![index];

print('--------------successfulRequestsData--------------------');
print(successfulRequestsData);
            //values for passing to the widget
            bloodGroup = successfulRequestsData.recipientBloodGroup;
            location = successfulRequestsData.streetName;
            patientName = successfulRequestsData.recipientName;
            caseOfRequest = successfulRequestsData.caseOfRequest;
            hospitalName = successfulRequestsData.hospitalName;
            contact = successfulRequestsData.contactOfRequestCreator;
            phoneNumber = successfulRequestsData.phoneNumberOfRequest;

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
                    },
                  ),
                ),
    );
  }
}
