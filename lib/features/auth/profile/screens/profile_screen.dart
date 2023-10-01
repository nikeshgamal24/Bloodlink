import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/common/widgets/bottom_nav_bar.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/constants/utils.dart';
import 'package:test/features/auth/profile/screens/coupons_detailed_list_screen.dart';
import 'package:test/features/auth/profile/screens/khalti_screen.dart';
import 'package:test/features/auth/profile/screens/my_created_requests.dart';
import 'package:test/features/auth/profile/screens/my_details_screen.dart';
import 'package:test/features/auth/profile/screens/successful_requests.dart';
import 'package:test/features/auth/profile/services/profile_user_details_service.dart';
import 'package:test/features/auth/screens/login.dart';
import 'package:test/models/user.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/my-profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileDetailService userProfileDetailService =
      UserProfileDetailService();
  List<User>? userDetailsList;
  int? id;

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, MyDetailsScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    fetchCurrentUserDetails();
  }

  fetchCurrentUserDetails() async {
    userDetailsList =
        await userProfileDetailService.fetchCurrentUserDetails(context);
         final rewardPoints = userDetailsList![0].rewardPoints;
        print('rewardPoints');
        print(rewardPoints);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          //reason to use the flexiblespace is that we want to have the linear Gradient to the AppBar but AppBar doesnot have the property lineargradiend so we use flexibleSpace
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.transparent,
                // height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: const Text(
                  'My Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                  ),
                ),
              ),
              Container(
                // color: Colors.transparent,
                // height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
      body: userDetailsList == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.buttonBackgroundColor,
                    ),
                    onPressed: navigateToDetailScreen,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "My Details",
                        style: TextStyle(
                          fontSize: 21,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.buttonBackgroundColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, MyCreatedRequest.routeName);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "My Requests",
                        style: TextStyle(
                          fontSize: 21,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.buttonBackgroundColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, SuccessfulRequestScreen.routeName);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "Successful Requests",
                        style: TextStyle(
                          fontSize: 21,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.buttonBackgroundColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, BottomBar.routeName, (route) => false);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 21,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.buttonBackgroundColor,
                    ),
                    onPressed: () async {
                      try {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString("x-auth-token", '');
                        Navigator.pushNamedAndRemoveUntil(
                            context, MyLogin.routeName, (route) => false);
                        showSnackBar(context, "You are logged out");
                      } catch (err) {
                        showSnackBar(context, err.toString());
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 21,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: GlobalVariables.khaltiAppColor,
                  //   ),
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, MyKhaltiScreen.routeName);
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     padding: const EdgeInsets.symmetric(vertical: 10),
                  //     child: const Text(
                  //       "Khalti",
                  //       style: TextStyle(
                  //         fontSize: 21,
                  //       ),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 130,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                          Text(
                           userDetailsList![0].rewardPoints.toString(),
                          style: const TextStyle(
                            fontSize: 33,
                            color: GlobalVariables.titleColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        const Text(
                          "Reward Points",
                          style: TextStyle(
                            fontSize: 27,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                GlobalVariables.buttonBackgroundColor,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, CouponsDetailsScreen.routeName);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              "Redeem",
                              style: TextStyle(
                                fontSize: 21,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
            ),
    );
  }
}
