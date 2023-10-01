import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test/constants/error_handling.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/constants/utils.dart';
import 'package:test/features/auth/profile/screens/my_created_requests.dart';
// import 'package:test/features/auth/request/activeRequest/screens/active_request_screen.dart';
import 'package:test/models/blood_request.dart';
import 'package:test/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class BloodRequestService {
  //sign up for user
  void createBloodRequest({
    required BuildContext context,
    required String recipientName,
    required String recipientBloodGroup,
    required int? requiredPints,
    required int? otp,
    required String hospitalName,
    required String streetName,
    required int postalCode,
    required int ward,
    required String city,
    required String country,
    required double? longitude,
    required double? latitude,
    List<dynamic>? acceptors,
    required String bloodRequiredDate,
    required String caseOfRequest,
    required String? contactOfRequestCreator,
    required int? phoneNumberOfRequest,

    // required String campaignLongitude,
    // required String campaignLatitude,
  }) async {
    try {
      BloodRequest bloodRequest = BloodRequest(
        id: '',
        recipientName: recipientName,
        recipientBloodGroup: recipientBloodGroup,
        requiredPints: requiredPints,
        otp: otp, // You can set it to 0 or handle it differently
        hospitalName: hospitalName,
        streetName: streetName,
        postalCode: postalCode,
        ward: ward,
        city: city,
        country: country,
        longitude: longitude, // Set it to null or handle it differently
        latitude: latitude, // Set it to null or handle it differently
        acceptors: acceptors, // Pass the list of acceptors
        bloodRequiredDate: bloodRequiredDate,
        caseOfRequest: caseOfRequest,
        contactOfRequestCreator: contactOfRequestCreator,
        phoneNumberOfRequest: phoneNumberOfRequest,
      );

      //post requrest and return response so need to pass in the form of json for which we pass it my headers
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      // we are sending the data
      print(bloodRequest.toJson());
      http.Response res = await http.post(
        Uri.parse('$uri/request/createRequest'),
        body: bloodRequest.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      print("-------auth service of test------after http request");
      print(res.body);

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Blood Request Sucessfylly Updated!');
          print(
              '===========Form validation sucessfully working================');
          Navigator.pushNamed(context, MyCreatedRequest.routeName);
        },
      );

      //clears all the data of the form once the data is successfully updated to the database
      // print(formKey.currentState);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
