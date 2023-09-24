import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test/constants/error_handling.dart';

import '../../../../constants/global_variables.dart';
import '../../../../constants/utils.dart';
import '../../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;

class UserServices {
  //returns the list of active donor
  Future<String> fetchAllActiveDonor(BuildContext context) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String dailyUpdatedData='';
    try {
      print("===========================================");
      print("Beginning activeDonorlist");
      print(userProvider.user.token);
      
      http.Response res = await http.get(
        Uri.parse('$uri/user/get-users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print("===========================================");
      print("End activeDonorlist");

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // for (int i = 0; i < jsonDecode(res.body).length; i++) {
            //   var roleAtIndexI =
            //       jsonDecode(res.body)[i]['role'].toString().toLowerCase();

            //   if (roleAtIndexI == "donor") {
            //     activeDonorlist.add(
            //       // have to convert into model
            //       User.fromJson(
            //         jsonEncode(
            //           jsonDecode(res.body)[i],
            //         ),
            //       ),
            //     );
            //   }

            print("===========================================");
            print("INside httErrorHandle section");
            print(jsonEncode(jsonDecode(res.body)));
            dailyUpdatedData=jsonEncode(jsonDecode(res.body));
            // print(json.decode(jsonEncode(jsonDecode(res.body)[i])));
            // }

            print(dailyUpdatedData);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return dailyUpdatedData;
  }



   Future<String> fetchActiveDonorDetails(BuildContext context) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String activeDonorsData='';
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/user/activeDonarCount'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print("===========================================");
      print("End fetchActiveDonorDetails");

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            print("==================fetchActiveDonorDetails=========================");
            print("INside httErrorHandle section");
            print(jsonEncode(jsonDecode(res.body)));
            print(jsonEncode(jsonDecode(res.body)).runtimeType);
            activeDonorsData=jsonEncode(jsonDecode(res.body));
            // print(json.decode(jsonEncode(jsonDecode(res.body)[i])));
            // }

            print(activeDonorsData);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return activeDonorsData;
  }
}
