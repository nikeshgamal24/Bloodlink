import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/common/widgets/profile_section.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:test/features/auth/campaign/services/campaign_details_services.dart';
import 'package:test/features/auth/campaign/widgets/campaign_details.dart';
import 'package:test/models/campaigns.dart';
import 'package:test/providers/user_provider.dart';

import '../../../../constants/global_variables.dart';

class ActiveCampaignScreen extends StatefulWidget {
  static const String routeName = '/campaigns-details';
  const ActiveCampaignScreen({super.key});

  @override
  State<ActiveCampaignScreen> createState() => _ActiveCampaignScreenState();
}

class _ActiveCampaignScreenState extends State<ActiveCampaignScreen> {
  final CampaignServices campaignServices = CampaignServices();
  List<Campaign>? campaignsList;
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
    fetchAllCampaigns();
  }

  fetchAllCampaigns() async {
    campaignsList = await campaignServices.fetchAllCampaigns(context);
    setState(() {
      // to re-build
    });
  }

  @override
  Widget build(BuildContext context) {

    userEmail = Provider.of<UserProvider>(context).user.email;
    String campaignTitle,
        campaignDays,
        campaignDayStatus,
        campaignStartTime,
        campaignEndTime,
        streetName;
    // campaignLongitude,
    // campaignLatitude;
    int goalPint, campaignContact;
    String campaignOrganizer, campaignEmail;
    String campaignEndDate;

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
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    child: Text(
                      "Active Campaigns",
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
      body: campaignsList == null
          ? const Loader()
          : campaignsList!.isEmpty
          ? const Center(
            child: Text(
              "Something went wrong with the server response",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: campaignsList!.length,
                itemBuilder: ((context, index) {
                  final campaignData = campaignsList![index];

                  //values for passing to the widget
                  campaignTitle = campaignData.campaignTitle;
                  campaignDays = campaignData.campaignDays;
                  campaignDayStatus = campaignData.campaignDayStatus;
                  campaignStartTime = campaignData.campaignStartTime;
                  campaignEndTime = campaignData.campaignEndTime;
                  campaignEndDate = campaignData.campaignEndDate;
                  streetName = campaignData.streetName;

                  // For google map
                  // campaignLongitude = campaignData.campaignLongitude;
                  // campaignLatitude = campaignData.campaignLatitude;

                  goalPint = campaignData.goalPint;
                  campaignOrganizer = campaignData.campaignOrganizer;
                  campaignEmail = campaignData.campaignEmail;
                  campaignContact = campaignData.campaignContact;
                  //return a colum for images and details of the product
                  return Column(
                    children: [
                      CampaignDetails(
                        campaignTitle: campaignTitle,
                        campaignDays: campaignDays,
                        campaignDayStatus: campaignDayStatus,
                        campaignStartTime: campaignStartTime,
                        campaignEndTime: campaignEndTime,
                        campaignEndDate: campaignEndDate,
                        streetName: streetName,
                        goalPint: goalPint,
                        campaignOrganizer: campaignOrganizer,
                        campaignEmail: campaignEmail,
                        campaignContact: campaignContact,
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
