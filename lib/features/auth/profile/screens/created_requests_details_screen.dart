import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/constants/error_handling.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/constants/utils.dart';
import 'package:test/features/auth/profile/services/my_created_requests_service.dart';
import 'package:test/features/auth/profile/widgets/acceptor_card.dart';
import 'package:test/features/auth/profile/widgets/detailed_request_section.dart';
import 'package:test/models/blood_request.dart';
import 'package:test/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class CreatedRequestDetailsScreen extends StatefulWidget {
  static const String routeName = '/created-request-details';

  const CreatedRequestDetailsScreen({super.key});

  @override
  State<CreatedRequestDetailsScreen> createState() =>
      _CreatedRequestDetailsScreenState();
}

class _CreatedRequestDetailsScreenState
    extends State<CreatedRequestDetailsScreen> {
  final MyCreatedRequestService myCreatedRequestService =
      MyCreatedRequestService();
  List<BloodRequest>? detailedRequest;
  String? id;

  @override
  void initState() {
    super.initState();
    // Use Future.delayed to ensure that context is available
    Future.delayed(Duration.zero, () async {
      // Get the id from the route arguments
      id = ModalRoute.of(context)!.settings.arguments as String?;

      // Check if id is not null before calling the self-calling function
      if (id != null) {
        detailedRequest = await fetchDetailsOfCurrentRequest(context, id!);
        setState(() {});
      }
    });
  }

  Future<List<BloodRequest>> fetchDetailsOfCurrentRequest(
      BuildContext context, String id) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<BloodRequest> detailedRequestList = [];
    try {
      print("===========================================");
      print("Current user token");
      print(id);

      http.Response res = await http.get(
        Uri.parse('$uri/request/details-of-request/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print("===========================================");
      print("End fetchDetailsOfCurrentRequest");

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            if (res.statusCode == 200) {
              final jsonData = json.decode(res.body);
              if (jsonData != null) {
                // Parse the JSON into a BloodRequest object
                detailedRequestList.add(BloodRequest.fromMap(jsonData));
              }
            }

            // Handle other status codes or invalid JSON here
            // return detailedRequestList;
            // showSnackBar(context, 'Request Deleted Successfully!');

            print(
                '------------------------fetchDetailsOfCurrentRequest-----------------');
            print(detailedRequestList);
            // Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return detailedRequestList;
  }

  @override
  Widget build(BuildContext context) {
    String bloodGroup,
        city,
        streetName,
        patientName,
        caseOfRequest,
        hospitalName,
        bloodRequiredDate;
    int? requiredPintCount, pintCollectedCount;
    // Rest of your widget's build method
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
                  'Request Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.transparent,
                  // height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: detailedRequest == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: detailedRequest!.length,
                itemBuilder: ((context, index) {
                  final detailedRequestData = detailedRequest![index];
                  print('--------detailedRequestData------------');
                  print(detailedRequestData);

                  //values for passing to the widget
                  patientName = detailedRequestData.recipientName;
                  bloodGroup = detailedRequestData.recipientBloodGroup;
                  requiredPintCount = detailedRequestData.requiredPints;
                  pintCollectedCount = detailedRequestData.pintCollectedCount;
                  hospitalName = detailedRequestData.hospitalName;
                  streetName = detailedRequestData.streetName;
                  city = detailedRequestData.city;
                  bloodRequiredDate = detailedRequestData.bloodRequiredDate;
                  caseOfRequest = detailedRequestData.caseOfRequest;
                  // contact = detailedRequestData.contactOfRequestCreator;
                  // phoneNumber = detailedRequestData.phoneNumberOfRequest;

                  List? acceptors = detailedRequestData.acceptors;
                  // contact = detailedRequestData.contactOfRequestCreator;
                  // phoneNumber = detailedRequestData.phoneNumberOfRequest;
                  //return a colum for images and details of the product
                  print('----------acceptors-----------');
                  final acceptor = jsonEncode(acceptors![index]);

                  // Parse the JSON string into a Map
                  Map<String, dynamic> jsonMap = json.decode(acceptor);

// Now you can access the values from the JSON
                  String acceptorName = jsonMap['acceptorName'];
                  int contactNumber = jsonMap['contactNumber'];
                  String email = jsonMap['email'];
                  String status = jsonMap['status'];

                  print(acceptorName);
                  print(contactNumber);
                  print(email);
                  print(status);
                  print('----------acceptors-----------');

                  return Column(
                    children: [
                      RequestDetailedSection(
                        patientName: patientName,
                        bloodGroup: bloodGroup,
                        requiredPintCount: requiredPintCount!,
                        pintCollectedCount: pintCollectedCount!,
                        hospitalName: hospitalName,
                        streetName: streetName,
                        city: city,
                        bloodRequiredDate: bloodRequiredDate,
                        caseOfRequest: caseOfRequest,
                        // contact: contact,
                        // phoneNumber: phoneNumber,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AcceptorCard(
                        acceptorName: acceptorName,
                        contactNumber: contactNumber,
                        email: email,
                        status: status,
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
