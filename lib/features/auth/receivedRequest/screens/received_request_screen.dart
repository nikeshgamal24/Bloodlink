import 'package:flutter/material.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/common/widgets/profile_section.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/features/auth/receivedRequest/services/received_request_sercive.dart';
import 'package:test/models/blood_request.dart';

class ReceivedRequestScreen extends StatefulWidget {
  const ReceivedRequestScreen({super.key});

  @override
  State<ReceivedRequestScreen> createState() => _ReceivedRequestScreenState();
}

class _ReceivedRequestScreenState extends State<ReceivedRequestScreen> {
  final MyReceivedRequestService myReceivedRequestService =
      MyReceivedRequestService();
  List<BloodRequest>? receivedRequestsList;

  @override
  void initState() {
    super.initState();
    fetchAllReceivedRequests();
  }

  fetchAllReceivedRequests() async {
    receivedRequestsList =
        await myReceivedRequestService.fetchAllReceivedRequests(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String bloodGroup, location, patientName, caseOfRequest, hospitalName, id;
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
                    "Received Requests",
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                    ),
                  )),
              const ProfileIcon(),
            ],
          ),
        ),
      ),
      body: receivedRequestsList == null
          ? const Loader()
          : receivedRequestsList!.isEmpty
              ? const Center(
                  child: Text(
                    "You don't have any requests notification yet!",
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
                    itemCount: receivedRequestsList!
                        .length, // The total number of items in the list
                    itemBuilder: (BuildContext context, int index) {
                      // This callback function builds each item in the list
                      // `context` is the current BuildContext
                      // `index` is the index of the item being built

                      // You can return a widget that represents each item based on the index
                      // For example, you can create a ListTile for a simple list:
                      final receivedBloodRequestData =
                          receivedRequestsList![index];
                      print('--------createdBloodRequestData--------------');
                      print(receivedBloodRequestData.phoneNumberOfRequest);
                      //values for passing to the widget
                      bloodGroup = receivedBloodRequestData.recipientBloodGroup;
                      location = receivedBloodRequestData.streetName;
                      patientName = receivedBloodRequestData.recipientName;
                      caseOfRequest = receivedBloodRequestData.caseOfRequest;
                      hospitalName = receivedBloodRequestData.hospitalName;
                      contact =
                          receivedBloodRequestData.contactOfRequestCreator;
                      phoneNumber =
                          receivedBloodRequestData.phoneNumberOfRequest;
                      id = receivedBloodRequestData.id;

                      return Padding(
                        padding: const EdgeInsets.only(bottom:10.0),
                        child: Container(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Required Blood: ",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 117, 23, 17),
                                                fontSize: 21,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              bloodGroup,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 207, 45, 34),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5.0),
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
                              ),
                              Container(
                                height: 2,
                                color: Colors.black12,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8),
                                child: SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: GlobalVariables
                                              .loginSignUpButtonBackgroundColor,
                                        ),
                                        onPressed: () {
                                          print(
                                              "-------Inside Accept button before funciton call-----------");
                                          myReceivedRequestService
                                              .acceptRequestResponse(context, id);
                                        },
                                        child: Container(
                                          width: 60,
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: const Text(
                                            "Accept",
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
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
