import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/common/widgets/profile_section.dart';
import 'package:test/features/auth/request/activeRequest/services/request_services.dart';
import 'package:test/features/auth/request/activeRequest/widgets/blood_request_details.dart';
import 'package:test/models/blood_request.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:test/providers/user_provider.dart';
import '../../../../../constants/global_variables.dart';

class ActiveRequestScreen extends StatefulWidget {
  static const String routeName='/active-all-requests';
  const ActiveRequestScreen({super.key});

  @override
  State<ActiveRequestScreen> createState() => _ActiveRequestScreenState();
}

class _ActiveRequestScreenState extends State<ActiveRequestScreen> {
  final RequestServices requestServices = RequestServices();
  List<BloodRequest>? bloodRequestList ;
   late IO.Socket socket;
  String? userEmail;

  @override
  void initState() {
    super.initState();
     socket = IO.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    // Initialize geolocation
    Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.best, distanceFilter: 10)
        .listen((Position position) {
      // print('Location data: ${position.latitude}, ${position.longitude}');
      // Send location data to the server
      socket.emit('location', {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'email':userEmail,
      });
    });
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
     userEmail = Provider.of<UserProvider>(context).user.email;
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
          title:const  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Row(
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
              ProfileIcon(),
            ],
          ),
        ),
      ),
      // fetcht the data and poulate the screen
      body: bloodRequestList == null
      ?const Loader()
      : Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: bloodRequestList!.length,
          itemBuilder: ((context, index) {
            final bloodRequestData = bloodRequestList![index];

            //values for passing to the widget
            bloodGroup = bloodRequestData.recipientBloodGroup;
            location = bloodRequestData.streetName;
            patientName = bloodRequestData.recipientName;
            caseOfRequest = bloodRequestData.caseOfRequest;
            hospitalName = bloodRequestData.hospitalName;
            contact = bloodRequestData.contactOfRequestCreator;
            phoneNumber = bloodRequestData.phoneNumberOfRequest;

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
