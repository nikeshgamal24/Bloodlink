import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test/constants/utils.dart';
import 'package:test/models/campaigns.dart';
import 'package:http/http.dart' as http;
import '../../../../constants/error_handling.dart';
import '../../../../constants/global_variables.dart';
import '../../../../providers/user_provider.dart';

class CampaignServices {
  Future<List<Campaign>> fetchAllCampaigns(BuildContext context) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Campaign> campaignsList = [];
    try {
      // print("===========================================");
      // print("Beginning fetchAllCampaigns");
      http.Response res = await http.get(
        Uri.parse('$uri/campaign/getCampaigns'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      // print("===========================================");
      // print("End fetchAllCampaigns");
      // print(jsonEncode(jsonDecode(res.body).length));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i <jsonDecode(res.body).length; i++) {
              campaignsList.add(
                // have to convert into model
                Campaign.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
              
              // print(jsonEncode(jsonDecode(res.body)[i]));
              // print(json.decode(jsonEncode(jsonDecode(res.body)[i])));
            }
            // print("=======BloodRequest List=========");
            // print(campaignsList);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return campaignsList;
  }
}
