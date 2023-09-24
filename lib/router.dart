import 'package:flutter/material.dart';
import 'package:test/common/widgets/bottom_nav_bar.dart';
import 'package:test/features/auth/campaign/screens/campaigns_details_screen.dart';
import 'package:test/features/auth/form/campaignForm/screens/campaign_form.dart';
import 'package:test/features/auth/home/screens/home_screen.dart';
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
    case CampaignCreateForm.routeName:
      return MaterialPageRoute(
        settings:routeSettings, 
        builder: (_)=> const CampaignCreateForm());
    default:
      return MaterialPageRoute(builder: (_)=> const Scaffold(
        body: Center(
          child: Text('Screen does not exist'),
          ),
        ),
      );
  }
}