import 'package:flutter/material.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/features/auth/campaign/screens/campaigns_details_screen.dart';
import 'package:test/features/auth/home/screens/home_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:test/features/auth/request/activeRequest/screens/active_request_screen.dart';
import 'package:test/features/auth/screens/create_screen.dart';


class BottomBar extends StatefulWidget {
  static const routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth=5;

//to correctly show the information
  List<Widget> pages=[
    const HomeScreen(),
    const Center(child: Text('Request Screen'),),
    const CreateScreen(),
    const ActiveRequestScreen(),
    const ActiveCampaignScreen(),
  ];

  void updatePage(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      //for the home screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
       backgroundColor: GlobalVariables.backgroundColor,
       iconSize: 28,
       // to determine we move the top horizontal line to the item wheere we do click indeed
       onTap: updatePage,
        items: [
          BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(top:BorderSide(
                color: _page == 0? GlobalVariables.selectedNavBarColor:GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth,
              ),
              ),
            ),
          child: const Icon(Icons.home_outlined),
          ),
          label: '',
          ),

          //For the request screen
          BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(top:BorderSide(
                color: _page == 1? GlobalVariables.selectedNavBarColor:GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth,
              ),
              ),
            ),
          child: const Icon(Icons.edit_note_outlined),
          ),
          label: '',
          ),

          //For the For request form button
          BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(top:BorderSide(
                color: _page == 2? GlobalVariables.selectedNavBarColor:GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth,
              ),
              ),
            ),
          child: const Icon(Icons.add_circle_outline),
          ),
          label: '',
          ),
  
          //For the active request 
          BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(top:BorderSide(
                color: _page == 3? GlobalVariables.selectedNavBarColor:GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth,
              ),
              ),
            ),
          child:const badges.Badge(
            badgeContent: Text('2'),
            badgeStyle: badges.BadgeStyle(
              elevation: 0,
              badgeColor: Colors.white,
            ),
            child: Icon(
              Icons.view_list_outlined,
              ),
            ),
          ),
          label: '',
          ),

            //For the campaigns 
            BottomNavigationBarItem(icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(top:BorderSide(
                  color: _page == 4? GlobalVariables.selectedNavBarColor:GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth,
              ),
              ),
            ),
          child:const badges.Badge(
            badgeContent: Text('3'),
            badgeStyle: badges.BadgeStyle(
              elevation: 0,
              badgeColor: Colors.white,
            ),
            child: Icon(
              Icons.campaign_outlined,
              ),
            ),
          ),
          label: '',
          ),
        ],
      ),
    );
  }
}