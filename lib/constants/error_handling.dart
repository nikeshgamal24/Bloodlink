import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test/constants/utils.dart';
import 'dart:convert'; //jsonDecode

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required Function()? onSuccess, // Function()? 
}){
  // based on the statusCode we will determine if we are having error part or warning 
  switch(response.statusCode){
    case 200:
      onSuccess!();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['message']); //we need to decode into json to use later on
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)["error"]);
      break;
    default:
      showSnackBar(context, response.body);
  }
}