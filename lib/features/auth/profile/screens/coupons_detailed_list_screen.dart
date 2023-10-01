import 'package:flutter/material.dart';
import 'package:test/common/widgets/loader.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/features/auth/profile/services/coupon_get_services.dart';
import 'package:test/features/auth/profile/widgets/coupon_card.dart';
import 'package:test/models/coupon.dart';

class CouponsDetailsScreen extends StatefulWidget {
  static const String routeName = '/all-coupons';
  const CouponsDetailsScreen({super.key});

  @override
  State<CouponsDetailsScreen> createState() => _CouponsDetailsScreenState();
}

class _CouponsDetailsScreenState extends State<CouponsDetailsScreen> {
  final CouponService couponService = CouponService();
  List<Coupon>? couponList = [];

  @override
  void initState() {
    super.initState();
    fetchAllCoupon();
  }

  fetchAllCoupon() async {
    couponList = await couponService.fetchAllCoupon(context);
    setState(() {
      //re-build
    });
  }

  @override
  Widget build(BuildContext context) {
String description,id;
int pointCost,availablePoints,disountPercentage;
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
                const Text(
                  "Get Various Coupons",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: 32,
                  ),
                )
              ],
            ),
          ),
        ),
        body: couponList == null
            ? const Loader()
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: couponList!
                        .length, // The total number of items in the list
                    itemBuilder: (BuildContext context, int index) {
                      // This callback function builds each item in the list
                      // `context` is the current BuildContext
                      // `index` is the index of the item being built

                      // You can return a widget that represents each item based on the index
                      // For example, you can create a ListTile for a simple list:
                     final couponData = couponList![index];
                     disountPercentage= couponData.disountPercentage;
                     description= couponData.description;
                      availablePoints =couponData.availablePoints;
                      pointCost = couponData.pointCost;
                      id =couponData.id;
                      return Column(
                        children: [
                          CouponCard(
                            id:id,
                            description: description,
                            pointCost: pointCost,
                            availablePoints: availablePoints,
                            disountPercentage: disountPercentage,
                          ),
                          const SizedBox(height: 10,),
                        ],
                      );
                    }),
              ));
  }
}
