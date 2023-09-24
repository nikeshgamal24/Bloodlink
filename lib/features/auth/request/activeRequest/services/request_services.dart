import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/blood_request.dart';
import 'package:http/http.dart' as http;
import '../../../../../constants/error_handling.dart';
import '../../../../../constants/global_variables.dart';
import '../../../../../constants/utils.dart';
import '../../../../../providers/user_provider.dart';

class RequestServices{
   Future<List<BloodRequest>> fetchAllRequests(BuildContext context) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<BloodRequest> bloodRequestList = [];
    try {
      print("===========================================");
      print("Beginning fetchAllProducts");
      http.Response res = await http.get(
        Uri.parse('$uri/request/getAllRequest'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print("===========================================");
      print("End fetchAllProducts");

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i <jsonDecode(res.body).length; i++) {
              bloodRequestList.add(
                // have to convert into model
                BloodRequest.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
              
              print(jsonEncode(jsonDecode(res.body)[i]));
              // print(json.decode(jsonEncode(jsonDecode(res.body)[i])));
            }
            print("=======BloodRequest List=========");
            print(bloodRequestList);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return bloodRequestList;
  }
}