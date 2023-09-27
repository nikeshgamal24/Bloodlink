

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/features/auth/profile/services/profile_user_details_service.dart';
import 'package:test/features/auth/profile/widgets/user_detail_item.dart';
import 'package:test/models/user.dart';

import '../../../../constants/global_variables.dart';

class MyDetailsScreen extends StatefulWidget {
  static const String routeName = '/my-details';
  const MyDetailsScreen({super.key});

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  final UserProfileDetailService userProfileDetailService =
      UserProfileDetailService();
  List<User>? userList;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserDetails();
  }

  fetchCurrentUserDetails() async {
    userList = await userProfileDetailService.fetchCurrentUserDetails(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("-----------UserProfileDetailService--------------------");

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
      body: userList == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount:
                    userList!.length, // The total number of items in the list
                itemBuilder: (BuildContext context, int index) {
                  // This callback function builds each item in the list
                  // `context` is the current BuildContext
                  // `index` is the index of the item being built

                  // You can return a widget that represents each item based on the index
                  // For example, you can create a ListTile for a simple list:
                  final user = userList![index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      UserDetailItem(label: "Name", value: user.name),
                      Container(
                        height: 3,
                        color: GlobalVariables.dividerColor,
                        width: 320,
                      ),
                      UserDetailItem(label: "Email", value: user.email),
                      Container(
                        height: 3,
                        color: GlobalVariables.dividerColor,
                        width: 320,
                      ),
                      UserDetailItem(
                          label: "Phone Number", value: user.phoneNumber),
                      Container(
                        height: 3,
                        color: GlobalVariables.dividerColor,
                        width: 320,
                      ),
                      UserDetailItem(label: "Address", value: user.address),
                      Container(
                        height: 3,
                        color: GlobalVariables.dividerColor,
                        width: 320,
                      ),
                      UserDetailItem(
                          label: "Blood Group", value: user.bloodGroup),
                      Container(
                        height: 3,
                        color: GlobalVariables.dividerColor,
                        width: 320,
                      ),
                      UserDetailItem(
                          label: "Last Blood Donated", value: user.lastDonated),
                      Container(
                        height: 3,
                        color: GlobalVariables.dividerColor,
                        width: 320,
                      ),
                      UserDetailItem(label: "Role", value: user.role!),
                      Container(
                        height: 3,
                        color: GlobalVariables.dividerColor,
                        width: 320,
                      ),
                      UserDetailItem(label: "Status", value: user.status!),
                      Container(
                        height: 3,
                        color: GlobalVariables.dividerColor,
                        width: 320,
                      ),
                       const Padding(
                        padding: EdgeInsets.only(top: 10.0,bottom:4,right:10,left: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child:  Text(
                            "Face Image:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      CarouselSlider(
                        items: user.faceImage.map(
                          (url) {
                            return Builder(
                              builder: (BuildContext context) => Image.network(
                                url,
                                fit: BoxFit.contain,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0,bottom:4,right:10,left: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child:  Text(
                            "Government Document:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      CarouselSlider(
                        items: user.governmentDocument.map(
                          (url) {
                            return Builder(
                              builder: (BuildContext context) => Image.network(
                                url,
                                fit: BoxFit.contain,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      ),const Padding(
                        padding: EdgeInsets.only(top: 10.0,bottom:4,right:10,left: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child:  Text(
                            "Medical Document:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      CarouselSlider(
                        items: user.medicalDocument.map(
                          (url) {
                            return Builder(
                              builder: (BuildContext context) => Image.network(
                                url,
                                fit: BoxFit.contain,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
