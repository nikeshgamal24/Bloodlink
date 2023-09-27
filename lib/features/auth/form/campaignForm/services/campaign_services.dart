import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/constants/utils.dart';
import 'package:test/features/auth/campaign/screens/campaigns_details_screen.dart';
import 'package:test/models/campaigns.dart';
import 'package:http/http.dart' as http;
import 'package:test/providers/user_provider.dart';

import '../../../../../constants/error_handling.dart';

class CampaignService {
  //sign up for user
  void createCampaign({
    required BuildContext context,
    required String campaignTitle,
    required String campaignDays,
    required String campaignDayStatus,
    required String campaignStartTime,
    required String campaignEndTime,
    required String campaignEndDate,
    required String streetName,
    required int postalCode,
    required int ward,
    required String city,
    required String country,
    required int goalPint,
    required String campaignOrganizer,
    required String campaignEmail,
    required int campaignContact,

    // required String campaignLongitude,
    // required String campaignLatitude,
  }) async {
    try {
      Campaign campaign = Campaign(
        id: '',
        campaignTitle: campaignTitle,
        campaignDays: campaignDays,
        campaignDayStatus: campaignDayStatus,
        campaignStartTime: campaignStartTime,
        campaignEndTime: campaignEndTime,
        campaignEndDate: campaignEndDate,
        streetName: streetName,
        postalCode: postalCode,
        ward: ward,
        city: city,
        country: country,
        campaignLongitude: '',
        campaignLatitude: '',
        goalPint: goalPint,
        campaignOrganizer: campaignOrganizer,
        campaignEmail: campaignEmail,
        campaignContact: campaignContact,
      );

      //post requrest and return response so need to pass in the form of json for which we pass it my headers
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      // we are sending the data
      print(campaign.toJson());
      http.Response res = await http.post(
        Uri.parse('$uri/campaign/create-campaign'),
        body: campaign.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      // print("-------auth service of test------after http request");
      // print(res.body);

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context,
              'Campaign Created Successfully!Soon published after verification');
          print(
              '===========Form validation sucessfully working================');
          Navigator.pushNamedAndRemoveUntil(
              context, ActiveCampaignScreen.routeName, (route) => false);
        },
      );

      //clears all the data of the form once the data is successfully updated to the database
      // print(formKey.currentState);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
