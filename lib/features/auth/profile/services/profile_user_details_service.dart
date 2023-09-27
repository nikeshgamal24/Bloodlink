import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test/constants/error_handling.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/constants/utils.dart';
import 'package:test/models/user.dart';
import 'package:test/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class UserProfileDetailService {
  Future<List<User>> fetchCurrentUserDetails(BuildContext context) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<User> userList = [];
    try {
      print("===========================================");
      print("Current user token");
      print(userProvider.user.id);

      http.Response res = await http.get(
        Uri.parse('$uri/user/get-user-details/${userProvider.user.id}'),
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
             for (int i = 0; i <jsonDecode(res.body).length; i++) {
              userList.add(
                // have to convert into model
                User.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
            print('------------------------userList-----------------');
            print(userList);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return userList;
  }
}
