import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test/common/widgets/bottom_nav_bar.dart';
import 'package:test/constants/error_handling.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/constants/utils.dart';
import 'package:test/models/coupon.dart';
import 'package:test/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class CouponService {
  Future<List<Coupon>> fetchAllCoupon(BuildContext context) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Coupon> couponList = [];
    try {
      print("=====================fetchAllCoupon======================");
      print("Current user token");
      print(userProvider.user.id);

      http.Response res = await http.get(
        Uri.parse('$uri/coupon/allCouponsForUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print("================fetchAllCoupon===========================");
      print("End fetchAllCoupon");

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
             for (int i = 0; i <jsonDecode(res.body).length; i++) {
              couponList.add(
                // have to convert into model
                Coupon.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
            print('------------------------fetchAllCoupon list-----------------');
            print(couponList);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return couponList;
  }


   Future<void> redeemCoupon(BuildContext context, String coupId) async {
    //we need user Provide to have the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Coupon> couponList = [];
    try {
      print("=====================fetchAllCoupon======================");
      print("coupId");
      print(coupId);

      http.Response res = await http.get(
        Uri.parse('$uri/coupon/redeemCoupon/$coupId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      print("================fetchAllCoupon===========================");
      print("End fetchAllCoupon");

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
             print('jsonDecode(res.body)["status"]');
            print(jsonDecode(res.body)["status"]);
             if(jsonDecode(res.body)["status"] == 'success'){
              showSnackBar(context, 'Successfully redeemed coupon of id: $coupId');
              Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route) => false);
             }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
