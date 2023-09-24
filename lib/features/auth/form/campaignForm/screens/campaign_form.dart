import 'package:flutter/material.dart';
import 'package:test/common/widgets/campaign_custom_textfield.dart';
import 'package:test/features/auth/form/campaignForm/services/campaign_services.dart';

import '../../../../../constants/global_variables.dart';
import '../../../../../constants/utils.dart';

class CampaignCreateForm extends StatefulWidget {
  static const String routeName = '/create-campaign';
  const CampaignCreateForm({Key? key}) : super(key: key);

  @override
  State<CampaignCreateForm> createState() => _CampaignCreateFormState();
}

class _CampaignCreateFormState extends State<CampaignCreateForm> {
  final CampaignService campaignService = CampaignService();

  //definine controller
  final TextEditingController _campaignTitleController =
      TextEditingController();
  final TextEditingController _campaignDaysController = TextEditingController();
  final TextEditingController _campaignDayStatusController =
      TextEditingController();
  final TextEditingController _campaignStartTimeController =
      TextEditingController();
  final TextEditingController _campaignEndTimeController =
      TextEditingController();
  final TextEditingController _campaignEndDateController =
      TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _goalPintController = TextEditingController();
  final TextEditingController _campaignOrganizerController =
      TextEditingController();
  final TextEditingController _campaignEmailController =
      TextEditingController();
  final TextEditingController _campaignContactController =
      TextEditingController();

  final _createCampaignFormKey = GlobalKey<FormState>();

  void createCampaign() {
    //validating form and after that manually checking if password and confirm password does match or not
    if (_createCampaignFormKey.currentState!.validate()) {
//checking for valid ward number
      print("=================city==========");
      print(_cityController.text.toLowerCase());
      switch (_cityController.text.toLowerCase()) {
        case "kathmandu":
          if (int.parse(_wardController.text) <= 0 ||
              int.parse(_wardController.text) > 32) {
            showSnackBar(
                context, "Invalid Ward number for Kathmandu!Out of bound");
            return;
          }
          break;
        case "lalitpur":
          if (int.parse(_wardController.text) <= 0 ||
              int.parse(_wardController.text) > 29) {
            showSnackBar(
                context, "Invalid Ward number for Lalitpur!Out of bound");
            return;
          }
          break;
        case "bhaktapur":
          if (int.parse(_wardController.text) <= 0 ||
              int.parse(_wardController.text) > 17) {
            showSnackBar(
                context, "Invalid Ward number for Bhaktapur!Out of bound");
            return;
          }
          break;
        default:
          if (int.parse(_wardController.text) <= 0 ||
              int.parse(_wardController.text) > 79) {
            showSnackBar(context, "Invalid ward number number!Out of bound");
            return;
          }
      }

      campaignService.createCampaign(
        context: context,
        // name: _nameController.text,
        // email: _emailRegContoller.text,
        // password: _passwordRegController.text,
        campaignTitle: _campaignTitleController.text,
        campaignDays: _campaignDaysController.text,
        campaignDayStatus: _campaignDayStatusController.text,
        campaignStartTime: _campaignStartTimeController.text,
        campaignEndTime: _campaignEndTimeController.text,
        campaignEndDate: _campaignEndDateController.text,
        streetName: _streetNameController.text,
        postalCode: int.parse(_postalCodeController.text),
        ward: int.parse(_wardController.text),
        city: _cityController.text,
        country: _countryController.text,
        goalPint: int.parse(_goalPintController.text),
        campaignOrganizer: _campaignOrganizerController.text,
        campaignEmail: _campaignEmailController.text,
        campaignContact: int.parse(_campaignContactController.text),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _campaignTitleController.dispose();
    _campaignDaysController.dispose();
    _campaignDayStatusController.dispose();
    _campaignStartTimeController.dispose();
    _campaignEndTimeController.dispose();
    _campaignEndDateController.dispose();
    _streetNameController.dispose();
    _postalCodeController.dispose();
    _wardController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _goalPintController.dispose();
    _campaignOrganizerController.dispose();
    _campaignEmailController.dispose();
    _campaignContactController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              const Spacer(),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
        child: SingleChildScrollView(
          child: Form(
            key: _createCampaignFormKey,
            child: Column(
              children: [
                CampaignCustomTextField(
                  controller: _campaignTitleController,
                  hintText: "Campaign Title",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _campaignDaysController,
                  hintText: "Campaign Day i.e. Sunday",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _campaignDayStatusController,
                  hintText: "Campaign Status i.e. Either 'Every' or ' '",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _campaignStartTimeController,
                  hintText: "Enter Campaign Start Time i.e. 10AM",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _campaignEndTimeController,
                  hintText: "Enter Campaign End Time i.e. 1PM",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _campaignEndDateController,
                  hintText: "Enter Campaign Date i.e. yy-mm-dd",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _streetNameController,
                  hintText: "Enter Street Name",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _postalCodeController,
                  hintText: "Enter Postal Code",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _wardController,
                  hintText: "Enter Ward Number",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _cityController,
                  hintText: "Enter City",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _countryController,
                  hintText: "Enter Country",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _goalPintController,
                  hintText: "Enter Goal of Pint Number",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _campaignOrganizerController,
                  hintText: "Enter Campaign Organizer",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _campaignEmailController,
                  hintText: "Enter Campaign Contact Email",
                ),
                const SizedBox(
                  height: 17,
                ),
                CampaignCustomTextField(
                  controller: _campaignContactController,
                  hintText: "Enter Campaign Contact Number",
                ),
                const SizedBox(
                  height: 17,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalVariables.buttonBackgroundColor,
                  ),
                  onPressed: createCampaign,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Create Campaign",
                      style: TextStyle(
                        fontSize: 21,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
