import 'package:flutter/material.dart';
import 'package:test/features/auth/campaign/services/campaign_details_services.dart';
import 'package:test/features/auth/campaign/widgets/campaign_details.dart';
import 'package:test/models/campaigns.dart';

import '../../../../constants/global_variables.dart';

class ActiveCampaignScreen extends StatefulWidget {
  static const String routeName = '/campaigns-details';
  const ActiveCampaignScreen({super.key});

  @override
  State<ActiveCampaignScreen> createState() => _ActiveCampaignScreenState();
}

class _ActiveCampaignScreenState extends State<ActiveCampaignScreen> {
  final CampaignServices campaignServices = CampaignServices();
  List<Campaign> campaignsList = [];

  @override
  void initState() {
    super.initState();
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
    String campaignTitle,
        campaignDays,
        campaignDayStatus,
        campaignStartTime,
        campaignEndTime,
        streetName;
        // campaignLongitude,
        // campaignLatitude;
    int goalPint, collectedPint, campaignContact;
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
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
          itemCount: campaignsList.length,
          itemBuilder: ((context, index) {
            final campaignData = campaignsList[index];

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
            collectedPint = campaignData.collectedPint;
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
                  collectedPint: collectedPint,
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
