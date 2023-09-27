
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:test/common/widgets/bottom_nav_bar.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/constants/utils.dart';
import 'package:test/models/blood_request.dart';

import '../../../../constants/error_handling.dart';
import '../../../../providers/user_provider.dart';

class MyCreatedRequestService {
  Future<List<BloodRequest>> fetchAllCreatedRequests(BuildContext context) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<BloodRequest> createdRequestsList = [];
    try {
      print("===========================================");
      print("Current user token");
      print(userProvider.user.id);

      http.Response res = await http.get(
        Uri.parse('$uri/request/getMyRequests'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print("===========================================");
      print("End fetchAllCreatedRequests");

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
             for (int i = 0; i <jsonDecode(res.body).length; i++) {
              createdRequestsList.add(
                // have to convert into model
                BloodRequest.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
            print('------------------------fetchAllCreatedRequestslist-----------------');
            print(createdRequestsList);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return createdRequestsList;
  }


  Future<List<BloodRequest>> deleteCreatedRequest(BuildContext context,String id) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<BloodRequest> deletedList = [];
    try {
      print("===========================================");
      print("Current user token");
      print(userProvider.user.id);

      http.Response res = await http.get(
        Uri.parse('$uri/request/delete-request/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print("===========================================");
      print("End deleteCreatedRequest");

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
          
              showSnackBar(context, 'Request Deleted Successfully!');
             
            print('------------------------deleteCreatedRequest-----------------');
            print(deletedList);
            Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  return deletedList;
  }



  Future<List<BloodRequest>> fetchDetailsOfCurrentRequest(BuildContext context,String id) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<BloodRequest> detailedRequestList = [];
    try {
      print("===========================================");
      print("Current user token");
      print(userProvider.user.id);

      http.Response res = await http.get(
        Uri.parse('$uri/request/details-of-request//$id'),
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
          
              // showSnackBar(context, 'Request Deleted Successfully!');
             
            print('------------------------fetchDetailsOfCurrentRequest-----------------');
            print(detailedRequestList);
            // Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  return detailedRequestList;
  }
}
