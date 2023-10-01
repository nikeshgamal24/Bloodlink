import 'package:flutter/material.dart';
import 'package:test/models/user.dart';

class UserProvider extends ChangeNotifier{
  User _user = User(
     id:'',
     name:'',
     age:0,
     sex:'',
     phoneNumber:'',
     bloodGroup:'',
     address: '',
     email:'',
     faceImage: [],
     governmentDocument: [],
     medicalDocument: [],
     role:'',
     status:'',
     password:'',
     rewardPoints:0,
     lastDonated: '',
     token:'',
  );

//this is a getter
  User get user=> _user;

//http post bata aayeko response we will pass here 
  void setUser(String user){
    print('Inside set user function');
    try {
    _user = User.fromJson(user); 
    } catch (e) {
      print(e);
    }
    print("Inside User provider");
    print("_user: $_user");
    notifyListeners(); // rebuild
  }
}