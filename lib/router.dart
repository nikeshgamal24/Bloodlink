import 'package:flutter/material.dart';
import 'package:test/common/widgets/bottom_nav_bar.dart';
import 'package:test/features/auth/campaign/screens/campaigns_details_screen.dart';
import 'package:test/features/auth/form/bloodRequestForm/blood_request_form.dart';
import 'package:test/features/auth/form/campaignForm/screens/campaign_form.dart';
import 'package:test/features/auth/home/screens/home_screen.dart';
import 'package:test/features/auth/profile/screens/coupons_detailed_list_screen.dart';
import 'package:test/features/auth/profile/screens/created_requests_details_screen.dart';
import 'package:test/features/auth/profile/screens/khalti_screen.dart';
import 'package:test/features/auth/profile/screens/my_created_requests.dart';
import 'package:test/features/auth/profile/screens/my_details_screen.dart';
import 'package:test/features/auth/profile/screens/profile_screen.dart';
import 'package:test/features/auth/profile/screens/successful_requests.dart';
import 'package:test/features/auth/receivedRequest/screens/received_request_screen.dart';
import 'package:test/features/auth/request/activeRequest/screens/active_request_screen.dart';
import 'package:test/features/auth/screens/login.dart';
import 'package:test/features/auth/screens/sign_up.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case MyLogin.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const MyLogin());
    case MySignUp.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const MySignUp());
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const BottomBar());
    case ActiveCampaignScreen.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const ActiveCampaignScreen());
    case ActiveRequestScreen.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const ActiveRequestScreen());
    case ReceivedRequestScreen.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const ReceivedRequestScreen());
    case ProfileScreen.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const ProfileScreen());
    case MyDetailsScreen.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const MyDetailsScreen());
    case BloodRequesCreateForm.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const BloodRequesCreateForm());
    case MyCreatedRequest.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const MyCreatedRequest());
    case CreatedRequestDetailsScreen.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const CreatedRequestDetailsScreen());
    case SuccessfulRequestScreen.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const SuccessfulRequestScreen());
    case CampaignCreateForm.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const CampaignCreateForm());
    case CouponsDetailsScreen.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const CouponsDetailsScreen());
    case MyKhaltiScreen.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const MyKhaltiScreen());
    default:
      return MaterialPageRoute(builder: (_)=> const Scaffold(
        body: Center(
          child: Text('Screen does not exist'),
          ),
        ),
      );
  }
}