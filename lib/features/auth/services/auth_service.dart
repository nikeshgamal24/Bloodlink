import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/common/widgets/bottom_nav_bar.dart';
import 'package:test/constants/utils.dart';
import 'package:test/constants/error_handling.dart';
import 'package:test/features/auth/screens/login.dart';
// import 'package:test/features/auth/home/screens/home_screem.dart';
import 'package:test/models/user.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/providers/user_provider.dart';

class AuthService {
  //sign up for user
  void signUpUser({
    required BuildContext context,
    required String name,
    required int age,
    required String sex,
    required String phoneNumber,
    required String bloodGroup,
    required String address,
    required String email,
    String? status,
    required String password,
    String? role,
    required List<File> faceImage,
    required List<File> governmentDocument,
    required List<File> medicalDocument,
    required String lastDonated,
    required String token,
  }) async {
    try {
//job is to store the images
      final cloudinary = CloudinaryPublic("dxc7qbvdk", 'yde7nlfp');

      //Work:: list of string images url --> map through all the images and send to cloudinary storage
      List<String> faceImageUrls = [];
      List<String> governmentDocumentUrls = [];
      List<String> medicalDocumentUrls = [];

      print("inside admin services cloudinary section to store images");
      for (int i = 0; i < faceImage.length; i++) {
        //cloudinary upload
        //  print('inside loop before async');
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(faceImage[i].path, folder: name));
        // print('inside loop after async');
        faceImageUrls.add(res.secureUrl);
      }

      for (int i = 0; i < governmentDocument.length; i++) {
        //cloudinary upload
        //  print('inside loop before async');
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(governmentDocument[i].path, folder: name));
        // print('inside loop after async');
        governmentDocumentUrls.add(res.secureUrl);
      }

      for (int i = 0; i < medicalDocument.length; i++) {
        //cloudinary upload
        //  print('inside loop before async');
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(medicalDocument[i].path, folder: name));
        // print('inside loop after async');
        medicalDocumentUrls.add(res.secureUrl);
      }

      print(
          "inside admin services uploading product detail to mongodb section");
      // work:: will be uploading the urls only to the mongodb

      User user = User(
        id: '',
        name: name,
        age: age,
        sex: sex,
        phoneNumber: phoneNumber,
        bloodGroup: bloodGroup,
        address: address,
        email: email,
        faceImage: faceImageUrls,
        governmentDocument: governmentDocumentUrls,
        medicalDocument: medicalDocumentUrls,
        role: 'recipient',
        status: 'UNVERIFIED',
        password: password,
        lastDonated: lastDonated,
        token: '',
      );

      //post requrest and return response so need to pass in the form of json for which we pass it my headers
      print('=============BEfore sign up api hit===========');
      print(user.toJson());

      // we are sending the data
      http.Response res = await http.post(
        Uri.parse('$uri/user/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      print("-------auth service of test------after http request");
      print(res.body);

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, 'Account created! Login with the same credentials');
          Navigator.pushNamedAndRemoveUntil(
              context, MyLogin.routeName, (route) => false);
        },
      );

      //clears all the data of the form once the data is successfully updated to the database
      // print(formKey.currentState);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//sign in for user
  void lognInUser({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      //post requrest and return response so need to pass in the form of json for which we pass it my headers
      print("=============+++WOrkin+++=============== login section");
      // we are sending the data
      http.Response res = await http.post(
        Uri.parse('$uri/user/login'),
        //send the data
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("Response body in sign in section");
      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // we need to save the state/ token to our device  so that we can persist the state of our device
          //what is persisting state?

          //plugin
          //shared preferences--->store token in app memory
          // provider---> store the user data
          print('setting sharepreference and provider work done');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print("=============Inside login function=================");
          print(res.body);
          print(jsonDecode(res.body)["token"]);
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          //set the data i.e. token
          await prefs.setString('x-auth-token', jsonDecode(res.body)["token"]);
          // Navigator.pushNamedAndRemoveUntil(
          //     context, BottomBar.routeName, (route) => false);
          showSnackBar(context, "Succesfully Logged In");
          print('setting navigator');
          Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route) => false);
        },
      );

      //clears all the data of the form once the data is successfully updated to the database
      // print(formKey.currentState);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//get user data
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      //first we want to have the sharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("--------------prefs------------ that was saved");
      print('toekn $prefs');
      String? token = prefs.getString('x-auth-token');
      // it there is no 'x-auth-token' it wll return null and if present it will give us the data
      print("--------------token------------ that was saved");
      print(token);

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      print("--------------token TESTING 2ND TIME------------ that was saved");
      print("token: $token");

      //checking if token is valid or not
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':
              token!, // token that we get from the shared prefereces
        },
      );

      print("token response after http post apit hit");
      print('tokenRes : $tokenRes');
      print(tokenRes.body);
      var response = jsonDecode(tokenRes.body); //will provide true or false

      if (response == true) {
        //get the user data  for that we need another api
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token':
                token, // token that we get from the shared prefereces
          },
        );

        print("Inside getUserData function");
        print(userRes.body);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        print("Inside getUserData function working");
        userProvider.setUser(userRes.body);
        print("Inside getUserData function working Fully");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
