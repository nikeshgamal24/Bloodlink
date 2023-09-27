import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/common/widgets/profile_section.dart';
import 'package:test/constants/utils.dart';
import 'package:test/features/auth/home/services/user_services.dart';
import 'package:test/features/auth/home/widgets/activedonor_detail.dart';
import 'package:test/features/auth/home/widgets/carousel_image.dart';
import 'package:test/features/auth/home/widgets/dailyupdate_container.dart';
import 'package:test/features/auth/home/widgets/donorcount_label.dart';
import 'package:test/features/auth/screens/login.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/constants/global_variables.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IO.Socket socket;
  String? userEmail;
  String? dailyUpdatedData;
  String? allActiveDonorsDetails;
  String? ap, bp, abp, op;
  String? an, bn, abn, on;
  double? bloodCountCalculation;
  int lowerBloodCountBound = 4, upperBloodCountBound = 6;
  final UserServices userServices = UserServices();

  @override
  void initState() {
    super.initState();
    // Initialize Socket.IO
 print('---------inside initState-----------userEmail-------------------');
    print(userEmail);
    socket = IO.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    // Initialize geolocation
    Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.best, distanceFilter: 10)
        .listen((Position position) {
      // print('Location data: ${position.latitude}, ${position.longitude}');
      // Send location data to the server
      socket.emit('location', {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'email':userEmail,
      });
    });

    fetchAllActiveDonor();
    fetchActiveDonorDetails();
    // fetch all active donor
  }

  fetchAllActiveDonor() async {
    dailyUpdatedData = await userServices.fetchAllActiveDonor(context);
    setState(() {});
  }

  fetchActiveDonorDetails() async {
    allActiveDonorsDetails =
        await userServices.fetchActiveDonorDetails(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String username = Provider.of<UserProvider>(context).user.name;
     userEmail = Provider.of<UserProvider>(context).user.email;


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
                  child: Text(
                    'Welcome, $username',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                const ProfileIcon(),
              ],
            ),
          ),
        ),
        body: (dailyUpdatedData == null || allActiveDonorsDetails == null)
            ? const Loader()
            : ListView.builder(
              itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> data = jsonDecode(dailyUpdatedData!);
                  Map<String, dynamic> activeDonorsDataResponse =
                      jsonDecode(allActiveDonorsDetails!);

                  //  positive blood Donor count
                  ap = activeDonorsDataResponse["data"]["ap"].toString();
                  bp = activeDonorsDataResponse["data"]["bp"].toString();
                  abp = activeDonorsDataResponse["data"]["abp"].toString();
                  op = activeDonorsDataResponse["data"]["op"].toString();

                  //  negative blood Donor count
                  an = activeDonorsDataResponse["data"]["an"].toString();
                  bn = activeDonorsDataResponse["data"]["bn"].toString();
                  abn = activeDonorsDataResponse["data"]["abn"].toString();
                  on = activeDonorsDataResponse["data"]["on"].toString();

                  @override
                  void dispose() {
                    socket.dispose();
                    super.dispose();
                  }

                  return SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CarouselImage(),
                        const SizedBox(
                          height: 3,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            backgroundColor:
                                const Color.fromARGB(255, 209, 68, 97),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            // minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                size: 25,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "FIND BLOOD",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Color.fromARGB(255, 250, 249, 249),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          child: Text(
                            "Today's Achievement",
                            style: TextStyle(
                              color: GlobalVariables.pageTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DailyUpdateContainer(
                                  updateDate: data["todaysRequest"],
                                  titleOfContainer: "New Request",
                                ),
                                DailyUpdateContainer(
                                  updateDate: data["pintCollectedCount"],
                                  titleOfContainer: "Pint Collected",
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const SizedBox(
                              child: Text(
                                "Our Achievement",
                                style: TextStyle(
                                  color: GlobalVariables.pageTitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DailyUpdateContainer(
                                  updateDate: data["successfulRequestCount"],
                                  titleOfContainer: "Successful Request",
                                ),
                                DailyUpdateContainer(
                                  updateDate: data["activeDonorCount"],
                                  titleOfContainer: "Active Donor",
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            backgroundColor:
                                const Color.fromARGB(255, 209, 68, 97),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            // minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            "BECOME A NEW DONOR",
                            style: TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(255, 250, 249, 249),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.black12,
                          height: 3,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Available Blood Group Count",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 112, 22, 22),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ActiveDonorDetail(
                                    bloodCount: op!,
                                    bloodGroup: "O+",
                                    textColor: int.parse(op!) <
                                            lowerBloodCountBound
                                        ? const Color.fromARGB(255, 226, 54, 42)
                                        : int.parse(op!) > upperBloodCountBound
                                            ? Colors.green.shade900
                                            : const Color.fromARGB(
                                                255, 9, 87, 151),
                                  ),
                                  ActiveDonorDetail(
                                    bloodCount: ap!,
                                    bloodGroup: "A+",
                                    textColor: int.parse(ap!) <
                                            lowerBloodCountBound
                                        ? const Color.fromARGB(255, 226, 54, 42)
                                        : int.parse(ap!) > upperBloodCountBound
                                            ? Colors.green.shade900
                                            : const Color.fromARGB(
                                                255, 9, 87, 151),
                                  ),
                                  ActiveDonorDetail(
                                    bloodCount: bp!,
                                    bloodGroup: "B+",
                                    textColor: int.parse(bp!) <
                                            lowerBloodCountBound
                                        ? const Color.fromARGB(255, 226, 54, 42)
                                        : int.parse(bp!) > upperBloodCountBound
                                            ? Colors.green.shade900
                                            : const Color.fromARGB(
                                                255, 9, 87, 151),
                                  ),
                                  ActiveDonorDetail(
                                    bloodCount: abp!,
                                    bloodGroup: "AB+",
                                    textColor: int.parse(abp!) <
                                            lowerBloodCountBound
                                        ? const Color.fromARGB(255, 226, 54, 42)
                                        : int.parse(abp!) > upperBloodCountBound
                                            ? Colors.green.shade900
                                            : const Color.fromARGB(
                                                255, 9, 87, 151),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ActiveDonorDetail(
                                    bloodCount: on!,
                                    bloodGroup: "O-",
                                    textColor: int.parse(on!) <
                                            lowerBloodCountBound
                                        ? const Color.fromARGB(255, 226, 54, 42)
                                        : int.parse(on!) > upperBloodCountBound
                                            ? Colors.green.shade900
                                            : const Color.fromARGB(
                                                255, 9, 87, 151),
                                  ),
                                  ActiveDonorDetail(
                                    bloodCount: an!,
                                    bloodGroup: "A-",
                                    textColor: int.parse(an!) <
                                            lowerBloodCountBound
                                        ? const Color.fromARGB(255, 226, 54, 42)
                                        : int.parse(an!) > upperBloodCountBound
                                            ? Colors.green.shade900
                                            : const Color.fromARGB(
                                                255, 9, 87, 151),
                                  ),
                                  ActiveDonorDetail(
                                    bloodCount: bn!,
                                    bloodGroup: "B-",
                                    textColor: int.parse(bn!) <
                                            lowerBloodCountBound
                                        ? const Color.fromARGB(255, 226, 54, 42)
                                        : int.parse(bn!) > upperBloodCountBound
                                            ? Colors.green.shade900
                                            : const Color.fromARGB(
                                                255, 9, 87, 151),
                                  ),
                                  ActiveDonorDetail(
                                    bloodCount: abn!,
                                    bloodGroup: "AB-",
                                    textColor: int.parse(abn!) <
                                            lowerBloodCountBound
                                        ? const Color.fromARGB(255, 226, 54, 42)
                                        : int.parse(abn!) > upperBloodCountBound
                                            ? Colors.green.shade900
                                            : const Color.fromARGB(
                                                255, 9, 87, 151),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ColorLabel(
                                  labelColor: Colors.red, textLabel: "Scant"),
                              ColorLabel(
                                  labelColor: Colors.blue,
                                  textLabel: "Abundant"),
                              ColorLabel(
                                  labelColor: Colors.green,
                                  textLabel: "Adequate"),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        
                      ],
                    ),
                  );
                },
              ));
  }
}
