
import 'package:flutter/material.dart';
import 'package:test/models/blood_request.dart';

class RequestProvider extends ChangeNotifier{
  BloodRequest _bloodRequest = BloodRequest(
     id:'',
     recipientName:'',
     recipientBloodGroup:'',
     hospitalName:'',
     streetName:'',
     postalCode:1,
     ward:1,
     city:'',
     country:'',
     bloodRequiredDate:DateTime.now(),
     caseOfRequest:'',
  );

//this is a getter
  BloodRequest get bloodRequest=> _bloodRequest;

//http post bata aayeko response we will pass here 
  void setUser(String bloodRequest){
    print('Inside set blood Request function');
    try {
    _bloodRequest = BloodRequest.fromJson(bloodRequest); 
    } catch (e) {
      print(e);
    }
    print("Inside bloodRequest provider");
    print("_user: $_bloodRequest");
    notifyListeners(); // rebuild
  }
}