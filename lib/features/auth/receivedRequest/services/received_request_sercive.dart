
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test/common/widgets/bottom_nav_bar.dart';
import 'package:test/constants/error_handling.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/constants/utils.dart';
import 'package:test/models/blood_request.dart';
import 'package:test/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class MyReceivedRequestService {
  Future<List<BloodRequest>> fetchAllReceivedRequests(BuildContext context) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<BloodRequest> receivedRequestsList = [];
    try {
      print("==============fetchAllReceivedRequests=============================");
      print("Current user token");
      //  print(jsonDecode(userProvider.toString()));
      print(userProvider.user.id);

      http.Response res = await http.get(
        Uri.parse('$uri/request/receivedRequest/${userProvider.user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print("===========================================");
      print("End fetchAllReceivedRequests");

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
             for (int i = 0; i <jsonDecode(res.body).length; i++) {
              receivedRequestsList.add(
                // have to convert into model
                BloodRequest.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
            print('------------------------MyReceivedRequestService-----------------');
            print(receivedRequestsList);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return receivedRequestsList;
  }

  Future<void> acceptRequestResponse(BuildContext context,String requestId) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // List<BloodRequest> acceptedRequestResponse = [];
    try {
      print("==============acceptRequestResponse=============================");
      print("Current user token");
      //  print(jsonDecode(userProvider.toString()));
      print(userProvider.user.id);
      print(' acceptRequestResponse requestId');
      print(requestId);

      http.Response res = await http.get(
        Uri.parse('$uri/request/acceptRequest/$requestId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print("===========================================");
      print("End acceptRequestResponse");

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            if(jsonDecode(res.body)){
              showSnackBar(context, "Please ,check your mail for your OTP  verification code!");
            }
            Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
